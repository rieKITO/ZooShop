//
//  StoresViewModel.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 30.10.2026.
//

import Combine
import Foundation
import Observation

@MainActor
@Observable
final class StoresViewModel {
    
    // MARK: - Private(set) Properties
    
    private(set) var stores: [Store] = []
    private(set) var errorMessage: String?
    private(set) var isLoading = true
    
    // MARK: - Observation Ignored
    
    @ObservationIgnored
    private let repository: any StoreRepository
    
    @ObservationIgnored
    private var hasLoaded = false

    @ObservationIgnored
    private var loadingSubscription: AnyCancellable?
    
    // MARK: - Initialization

    init(repository: any StoreRepository) {
        self.repository = repository
    }
    
    // MARK: - Public Methods

    func loadIfNeeded() {
        guard !hasLoaded else {
            return
        }

        loadStores()
    }

    func loadStores() {
        guard loadingSubscription == nil else {
            return
        }

        isLoading = true
        errorMessage = nil

        loadingSubscription = repository.loadStores()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else {
                    return
                }

                isLoading = false
                loadingSubscription = nil

                if case .failure(let error) = completion {
                    errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] stores in
                self?.stores = stores
                self?.hasLoaded = true
            }
    }

}
