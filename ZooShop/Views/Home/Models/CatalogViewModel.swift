//
//  CatalogViewModel.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 10.10.2026.
//

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
    private var loadingTask: Task<Void, Never>?
    
    // MARK: - Initialization

    init(repository: any ProductRepository) {
        self.repository = repository
    }
    
    // MARK: - Public Methods

    func loadIfNeeded() async {
        guard !hasLoaded else {
            return
        }

        await loadProducts()
    }

    func loadProducts() async {
        if let loadingTask {
            await loadingTask.value
            return
        }

        let task = Task { [weak self] in
            guard let self else {
                return
            }
            
            isLoading = true
            errorMessage = nil
            
            defer {
                isLoading = false
                loadingTask = nil
            }
            
            do {
                products = try await repository.loadProducts()
                hasLoaded = true
            } catch {
                errorMessage = error.localizedDescription
            }
        }

        loadingTask = task
        await task.value
    }

}
