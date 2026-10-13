//
//  PreviewFavoritesService.swift
//  ZooShop
//
// Created by Aleksandr Potemkin on 13.10.2026.
//

#if DEBUG
@MainActor
final class PreviewFavoritesService: FavoritesService {
    
    // MARK: - Private Properties
    
    private var productIDs: Set<String>
    
    // MARK: - Initialization

    init(productIDs: Set<String> = []) {
        self.productIDs = productIDs
    }
    
    // MARK: - Public Properties

    func fetchProductIDs() throws -> Set<String> {
        productIDs
    }

    func setFavorite(_ isFavorite: Bool, productID: String) throws {
        if isFavorite {
            productIDs.insert(productID)
        } else {
            productIDs.remove(productID)
        }
    }
}
#endif
