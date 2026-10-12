//
//  ProductRepository.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 10.10.2026.
//

@MainActor
protocol ProductRepository {
    func loadProducts() async throws -> [ProductItem]
}
