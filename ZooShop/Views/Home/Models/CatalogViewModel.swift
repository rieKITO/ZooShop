//
//  CatalogViewModel.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 10.10.2026.
//

import Combine
import Foundation
import Observation

@MainActor
@Observable
final class CatalogViewModel {
    
    // MARK: - Private(set) Properties
    
    private(set) var products: [ProductItem] = []
    private(set) var errorMessage: String?
    private(set) var isLoading = true
    
    // MARK: - Observation Ignored
    
    @ObservationIgnored
    private let repository: any ProductRepository
    
    @ObservationIgnored
    private var hasLoaded = false

    @ObservationIgnored
    private var loadingSubscription: AnyCancellable?
    
    // MARK: - Initialization

    init(repository: any ProductRepository) {
        self.repository = repository
    }
    
    // MARK: - Public Methods

    func loadIfNeeded() {
        guard !hasLoaded else {
            return
        }

        loadProducts()
    }

    func loadProducts() {
        guard loadingSubscription == nil else {
            return
        }

        isLoading = true
        errorMessage = nil

        loadingSubscription = repository.loadProducts()
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
            } receiveValue: { [weak self] products in
                self?.products = products
                self?.hasLoaded = true
            }
    }

}
