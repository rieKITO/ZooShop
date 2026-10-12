//
//  FavoritesViewModel.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 09.10.2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class FavoritesViewModel {
    
    // MARK: - Private(set) Properties
    
    private(set) var productIDs: Set<String> = []
    private(set) var isAvailable = false
    
    // MARK: - Public Properties
    
    var errorMessage: String?
    
    // MARK: - Observation Ignored

    @ObservationIgnored
    private var service: (any FavoritesService)?
    
    // MARK: - Initialization

    init(service: any FavoritesService) {
        self.service = service
        do {
            productIDs = try service.fetchProductIDs()
            isAvailable = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private init(error: Error) {
        errorMessage = error.localizedDescription
    }
    
    // MARK: - Public Methods

    static func make(
        inMemory: Bool = false,
        bundle: Bundle = .main,
        storeURL: URL? = nil
    ) -> FavoritesViewModel {
        do {
            return FavoritesViewModel(service: try CoreDataFavoritesService(
                inMemory: inMemory, bundle: bundle, storeURL: storeURL
            ))
        } catch {
            return FavoritesViewModel(error: error)
        }
    }

    func contains(_ productID: String) -> Bool {
        productIDs.contains(productID)
    }

    func toggle(_ productID: String) {
        guard
            isAvailable,
            let service
        else {
            return
        }

        let newValue = !contains(productID)
        do {
            try service.setFavorite(newValue, productID: productID)
            
            if newValue {
                productIDs.insert(productID)
            } else {
                productIDs.remove(productID)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

}
