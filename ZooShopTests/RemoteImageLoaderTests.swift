import Combine
import UIKit
import XCTest
@testable import ZooShop

@MainActor
final class RemoteImageLoaderTests: XCTestCase {
    func testLoaderCanBeReleasedOutsideSwiftTask() {
        weak var releasedLoader: RemoteImageLoader?
        do {
            let loader = RemoteImageLoader(session: .shared, diskCache: ImageDiskCache())
            releasedLoader = loader
            _ = loader.image(for: URL(string: "https://example.com/not-requested.png")!)
        }
        XCTAssertNil(releasedLoader)
    }

    func testSharedRequestSurvivesSubscriberCancellationAndPopulatesCache() async throws {
        let fixture = Fixture()
        defer { fixture.cleanUp() }
        let started = expectation(description: "Network request started")
        fixture.server.onStart = { started.fulfill() }

        var first: AnyCancellable? = fixture.loader.image(for: fixture.url)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in
                XCTFail("Cancelled subscriber received an image")
            })
        let received = expectation(description: "Second subscriber received image")
        let second = fixture.loader.image(for: fixture.url)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in received.fulfill() })

        await fulfillment(of: [started], timeout: 3)
        first?.cancel()
        first = nil
        fixture.server.respond(status: 200, data: fixture.imageData)
        await fulfillment(of: [received], timeout: 3)
        XCTAssertEqual(fixture.server.requestCount, 1)
        XCTAssertEqual(fixture.cache.data(for: fixture.url), fixture.imageData)

        let result = await result(from: fixture.loader.image(for: fixture.url))
        XCTAssertNotNil(try result.get())
        XCTAssertEqual(fixture.server.requestCount, 1, "Completed request must be served from disk")
        withExtendedLifetime(second) {}
    }

    func testCorruptCacheIsReplacedWithDownloadedImage() async throws {
        let fixture = Fixture()
        defer { fixture.cleanUp() }
        fixture.cache.save(Data("corrupt".utf8), for: fixture.url)
        fixture.server.onStart = { [server = fixture.server, data = fixture.imageData] in
            server.respond(status: 200, data: data)
        }

        let loaded = await result(from: fixture.loader.image(for: fixture.url))
        XCTAssertNotNil(try loaded.get())
        XCTAssertEqual(fixture.server.requestCount, 1)
        XCTAssertEqual(fixture.cache.data(for: fixture.url), fixture.imageData)
    }

    func testHTTPFailureIsNotCachedAndAllowsRetry() async throws {
        let fixture = Fixture()
        defer { fixture.cleanUp() }
        fixture.server.onStart = { [server = fixture.server] in
            server.respond(status: 503, data: Data())
        }
        let failed = await result(from: fixture.loader.image(for: fixture.url))
        guard case .failure(let error) = failed,
              case RemoteImageLoader.LoadingError.httpStatus(503) = error else {
            return XCTFail("Expected HTTP status error")
        }
        XCTAssertNil(fixture.cache.data(for: fixture.url))

        fixture.server.onStart = { [server = fixture.server, data = fixture.imageData] in
            server.respond(status: 200, data: data)
        }
        let retried = await result(from: fixture.loader.image(for: fixture.url))
        XCTAssertNotNil(try retried.get())
        XCTAssertEqual(fixture.server.requestCount, 2)
    }

    func testInvalidImageIsNotCached() async {
        let fixture = Fixture()
        defer { fixture.cleanUp() }
        fixture.server.onStart = { [server = fixture.server] in
            server.respond(status: 200, data: Data("not an image".utf8))
        }
        let failed = await result(from: fixture.loader.image(for: fixture.url))
        guard case .failure(let error) = failed,
              case RemoteImageLoader.LoadingError.invalidImage = error else {
            return XCTFail("Expected invalid image error")
        }
        XCTAssertNil(fixture.cache.data(for: fixture.url))
    }

    private func result(from publisher: AnyPublisher<UIImage, Error>) async -> Result<UIImage, Error> {
        let finished = expectation(description: "Publisher completed")
        var result: Result<UIImage, Error> = .failure(URLError(.unknown))
        let subscription = publisher.sink { completion in
            if case .failure(let error) = completion { result = .failure(error) }
            finished.fulfill()
        } receiveValue: { result = .success($0) }
        await fulfillment(of: [finished], timeout: 3)
        withExtendedLifetime(subscription) {}
        return result
    }
}

@MainActor
private final class Fixture {
    let url = URL(string: "https://images.example.com/\(UUID().uuidString).png")!
    let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
    let server = ImageServer()
    let session: URLSession
    let cache: ImageDiskCache
    let loader: RemoteImageLoader
    let imageData: Data

    init() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ImageURLProtocol.self]
        session = URLSession(configuration: configuration)
        cache = ImageDiskCache(directory: directory)
        loader = RemoteImageLoader(session: session, diskCache: cache)
        imageData = UIGraphicsImageRenderer(size: CGSize(width: 2, height: 2)).pngData { context in
            UIColor.red.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 2, height: 2))
        }
        ImageURLProtocol.registry.register(server, for: url)
    }

    func cleanUp() {
        session.invalidateAndCancel()
        ImageURLProtocol.registry.remove(for: url)
        try? FileManager.default.removeItem(at: directory)
    }
}

nonisolated private final class ImageServer: @unchecked Sendable {
    private let lock = NSLock()
    private var requests: [ImageURLProtocol] = []
    private var startHandler: (() -> Void)?

    var onStart: (() -> Void)? {
        get { lock.withLock { startHandler } }
        set { lock.withLock { startHandler = newValue } }
    }

    var requestCount: Int { lock.withLock { requests.count } }

    func start(_ request: ImageURLProtocol) {
        let handler = lock.withLock {
            requests.append(request)
            return startHandler
        }
        handler?()
    }

    func respond(status: Int, data: Data) {
        guard let request = lock.withLock({ requests.last }), let url = request.request.url else { return }
        let response = HTTPURLResponse(url: url, statusCode: status, httpVersion: nil, headerFields: nil)!
        request.client?.urlProtocol(request, didReceive: response, cacheStoragePolicy: .notAllowed)
        request.client?.urlProtocol(request, didLoad: data)
        request.client?.urlProtocolDidFinishLoading(request)
    }
}

nonisolated private final class ImageURLProtocol: URLProtocol, @unchecked Sendable {
    static let registry = Registry()

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    override func startLoading() {
        guard let url = request.url, let server = Self.registry.server(for: url) else {
            client?.urlProtocol(self, didFailWithError: URLError(.badURL))
            return
        }
        server.start(self)
    }
    override func stopLoading() {}

    final class Registry: @unchecked Sendable {
        private let lock = NSLock()
        private var servers: [URL: ImageServer] = [:]
        func register(_ server: ImageServer, for url: URL) { lock.withLock { servers[url] = server } }
        func server(for url: URL) -> ImageServer? { lock.withLock { servers[url] } }
        func remove(for url: URL) { lock.withLock { servers[url] = nil } }
    }
}
