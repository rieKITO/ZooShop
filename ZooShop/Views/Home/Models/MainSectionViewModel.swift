//
//  MainSectionViewModel.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 09.10.2026.
//

import Observation

@MainActor
@Observable
final class MainSectionViewModel {
    
    // MARK: - Public Properties
    
    let catalog: CatalogViewModel
    let favorites: FavoritesViewModel
    
    // MARK: - Computed Properties
    
    var favoriteProducts: [ProductItem] {
        catalog.products.filter { favorites.contains($0.id) }
    }

    var isLoading: Bool {
        catalog.isLoading
    }

    var errorMessage: String? {
        catalog.errorMessage
    }

    // MARK: - Initialization

    init(catalog: CatalogViewModel, favorites: FavoritesViewModel) {
        self.catalog = catalog
        self.favorites = favorites
    }

    // MARK: - Public Methods

    func loadIfNeeded() async {
        await catalog.loadIfNeeded()
    }

    func retry() async {
        await catalog.loadProducts()
    }

    func toggleFavorite(_ productID: String) {
        favorites.toggle(productID)
    }

}
