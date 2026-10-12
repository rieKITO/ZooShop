//
//  FavoritesService.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 09.10.2026.
//

import Foundation

@MainActor
protocol FavoritesService {
    func fetchProductIDs() throws -> Set<String>
    func setFavorite(_ isFavorite: Bool, productID: String) throws
}
