//
//  RemoteImageLoader.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 22.10.2026.
//

import Combine
import Foundation
import UIKit

@MainActor
final class RemoteImageLoader: ImageLoading {

    // MARK: - Private Properties

    private let session: URLSession
    private let diskCache: ImageDiskCache
    private let processingQueue = DispatchQueue(label: "ZooShop.ImageProcessing", qos: .userInitiated)
    private var requests: [URL: Request] = [:]

    // MARK: - Initialization

    init(session: URLSession, diskCache: ImageDiskCache) {
        self.session = session
        self.diskCache = diskCache
    }

    // Subscriptions cancel on release; teardown needs no actor executor hop.
    nonisolated deinit {}

    // MARK: - Public Methods

    func image(for url: URL) -> AnyPublisher<UIImage, Error> {
        // Subscribe lazily and serialize access to the shared request registry.
        Deferred { [self] in
            sharedImage(for: url)
        }
        .subscribe(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    // MARK: - Error

    enum LoadingError: Error {
        case invalidResponse
        case httpStatus(Int)
        case invalidImage
    }
}

private extension RemoteImageLoader {

    func sharedImage(for url: URL) -> AnyPublisher<UIImage, Error> {
        if let request = requests[url] {
            return request.publisher
        }

        let result = CurrentValueSubject<Result<UIImage, Error>?, Never>(nil)

        // The loader owns the subscription: cancelling one view must not cancel
        // work used by another view. Completed requests still populate the cache.
        let subscription = Self.loadImage(
            for: url,
            session: session,
            diskCache: diskCache,
            queue: processingQueue
        )
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            if case .failure(let error) = completion {
                result.send(.failure(error))
            }
            self?.requests[url] = nil
        } receiveValue: { image in
            result.send(.success(image))
        }

        // Delivery is scheduled on main, so registration precedes completion.
        let request = Request(result: result, subscription: subscription)
        requests[url] = request
        return request.publisher
    }

    nonisolated static func loadImage(
        for url: URL,
        session: URLSession,
        diskCache: ImageDiskCache,
        queue: DispatchQueue
    ) -> AnyPublisher<UIImage, Error> {
        Deferred {
            Just(diskCache.data(for: url))
        }
        .subscribe(on: queue)
        .flatMap { data -> AnyPublisher<UIImage, Error> in
            if let data {
                if let image = prepareImage(from: data) {
                    return Just(image).setFailureType(to: Error.self).eraseToAnyPublisher()
                }
                diskCache.remove(for: url)
            }

            return session.dataTaskPublisher(for: url)
                .tryMap { data, response in
                    guard let response = response as? HTTPURLResponse else {
                        throw LoadingError.invalidResponse
                    }
                    guard (200..<300).contains(response.statusCode) else {
                        throw LoadingError.httpStatus(response.statusCode)
                    }
                    return data
                }
                .receive(on: queue)
                .tryMap { data in
                    guard let image = prepareImage(from: data) else {
                        throw LoadingError.invalidImage
                    }
                    diskCache.save(data, for: url)
                    return image
                }
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }

    nonisolated static func prepareImage(from data: Data) -> UIImage? {
        guard let image = UIImage(data: data) else { return nil }
        return image.preparingForDisplay() ?? image
    }

    struct Request {
        // Replay one result to subscribers attaching while completion is queued.
        let result: CurrentValueSubject<Result<UIImage, Error>?, Never>
        let subscription: AnyCancellable

        var publisher: AnyPublisher<UIImage, Error> {
            result
                .compactMap { $0 }
                .tryMap { try $0.get() }
                .first()
                .eraseToAnyPublisher()
        }
    }
}
