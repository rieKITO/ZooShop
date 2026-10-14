//
//  ProductRepository.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 10.10.2026.
//

import Combine

@MainActor
protocol ProductRepository {
    func loadProducts() -> AnyPublisher<[ProductItem], Error>
}
