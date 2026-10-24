//
//  RemoteImageViewModelTests.swift
//  ZooShop
//
// Created by Aleksandr Potemkin on 22.10.2026.
//

import Combine
import SwiftUI
import XCTest
@testable import ZooShop

@MainActor
final class RemoteImageViewModelTests: XCTestCase {
    private let firstURL = URL(string: "https://example.com/first.png")!
    private let secondURL = URL(string: "https://example.com/second.png")!

    func testSuccessIsReusedAndHiddenForAnotherURL() async {
        let viewModel = RemoteImageViewModel()
        let loader = StubLoader()
        viewModel.load(firstURL, using: loader)
        loader.succeed()
        await drainMainQueue()
        viewModel.load(firstURL, using: loader)

        XCTAssertNotNil(viewModel.phase(for: firstURL).image)
        XCTAssertEqual(loader.calls, 1)
        guard case .empty = viewModel.phase(for: secondURL) else {
            return XCTFail("A new URL must not display the old image")
        }
    }

    func testFailureCanBeRetried() async {
        let viewModel = RemoteImageViewModel()
        let loader = StubLoader()
        viewModel.load(firstURL, using: loader)
        loader.subject.send(completion: .failure(URLError(.notConnectedToInternet)))
        await drainMainQueue()
        XCTAssertNotNil(viewModel.phase(for: firstURL).error)

        loader.subject = PassthroughSubject()
        viewModel.load(firstURL, using: loader)
        loader.succeed()
        await drainMainQueue()
        XCTAssertNotNil(viewModel.phase(for: firstURL).image)
        XCTAssertEqual(loader.calls, 2)
    }

    func testCancellationDropsQueuedResultAndAllowsReload() async {
        let viewModel = RemoteImageViewModel()
        let loader = StubLoader()
        viewModel.load(firstURL, using: loader)
        loader.subject.send(UIImage())
        viewModel.cancel()
        await drainMainQueue()

        XCTAssertEqual(loader.cancellations, 1)
        guard case .empty = viewModel.phase(for: firstURL) else {
            return XCTFail("Cancelled results must not update the UI")
        }
        viewModel.load(firstURL, using: loader)
        loader.succeed()
        await drainMainQueue()
        XCTAssertNotNil(viewModel.phase(for: firstURL).image)
    }

    func testOldQueuedSuccessDoesNotReplaceNewerFailure() async {
        let viewModel = RemoteImageViewModel()
        let oldLoader = StubLoader()
        viewModel.load(firstURL, using: oldLoader)
        oldLoader.subject.send(UIImage())
        viewModel.cancel()

        let newLoader = StubLoader()
        viewModel.load(firstURL, using: newLoader)
        newLoader.subject.send(completion: .failure(URLError(.badServerResponse)))
        await drainMainQueue()
        XCTAssertNotNil(viewModel.phase(for: firstURL).error)
        XCTAssertNil(viewModel.phase(for: firstURL).image)
    }

    func testURLChangeCancelsOldSubscriptionAndDropsQueuedFailure() async {
        let viewModel = RemoteImageViewModel()
        let oldLoader = StubLoader()
        viewModel.load(firstURL, using: oldLoader)
        oldLoader.subject.send(completion: .failure(URLError(.timedOut)))

        let newLoader = StubLoader()
        viewModel.load(secondURL, using: newLoader)
        newLoader.succeed()
        await drainMainQueue()
        XCTAssertNotNil(viewModel.phase(for: secondURL).image)
        XCTAssertNil(viewModel.phase(for: secondURL).error)
    }

    func testRepeatedAppearanceDoesNotDuplicateActiveSubscription() {
        let viewModel = RemoteImageViewModel()
        let loader = StubLoader()
        viewModel.load(firstURL, using: loader)
        viewModel.load(firstURL, using: loader)
        XCTAssertEqual(loader.calls, 1)
        viewModel.cancel()
        XCTAssertEqual(loader.cancellations, 1)
    }

    private func drainMainQueue() async {
        await withCheckedContinuation { continuation in
            DispatchQueue.main.async { continuation.resume() }
        }
    }
}

@MainActor
private final class StubLoader: ImageLoading {
    var calls = 0
    var cancellations = 0
    var subject = PassthroughSubject<UIImage, Error>()

    func image(for url: URL) -> AnyPublisher<UIImage, Error> {
        calls += 1
        return subject
            .handleEvents(receiveCancel: { [weak self] in self?.cancellations += 1 })
            .eraseToAnyPublisher()
    }

    func succeed() {
        subject.send(UIImage())
        subject.send(completion: .finished)
    }
}
