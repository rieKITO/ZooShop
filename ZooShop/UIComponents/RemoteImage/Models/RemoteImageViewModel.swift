//
//  RemoteImageViewModel.swift
//  ZooShop
//
// Created by Aleksandr Potemkin on 22.10.2026.
//

import Combine
import Observation
import SwiftUI

@MainActor
@Observable
final class RemoteImageViewModel {

    // MARK: - Private Properties

    private var state: State?

    @ObservationIgnored
    private var requestID: UUID?

    @ObservationIgnored
    private var subscription: AnyCancellable?

    nonisolated deinit {}

    // MARK: - Public Methods

    func phase(for url: URL) -> AsyncImagePhase {
        guard let state, state.url == url else {
            return .empty
        }
        
        return state.phase
    }

    func load(_ url: URL, using loader: any ImageLoading) {
        if state?.url == url {
            if case .success = state?.phase {
                return
            }
            
            if subscription != nil {
                return
            }
        }

        cancel()
        let requestID = UUID()
        self.requestID = requestID
        state = State(url: url, phase: .empty)

        subscription = loader.image(for: url)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self, self.requestID == requestID else {
                    return
                }
                
                subscription = nil
                if case .failure(let error) = completion {
                    state = State(url: url, phase: .failure(error))
                }
            } receiveValue: { [weak self] image in
                guard let self, self.requestID == requestID else {
                    return
                }
                
                state = State(url: url, phase: .success(Image(uiImage: image)))
            }
    }

    func cancel() {
        requestID = nil
        subscription?.cancel()
        subscription = nil
    }

    // MARK: - State

    private struct State {
        let url: URL
        let phase: AsyncImagePhase
    }
}
