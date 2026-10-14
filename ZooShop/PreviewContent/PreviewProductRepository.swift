//
//  PreviewProductRepository.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 10.10.2026.
//

#if DEBUG
import Combine
import Foundation

@MainActor
struct PreviewProductRepository: ProductRepository {
    
    // MARK: - Static Properties
    
    private static let imageURL: URL = {
        guard let url = URL(string: "https://example.invalid/preview-product.png") else {
            preconditionFailure("Invalid image URL in PreviewProductRepository")
        }
        return url
    }()

    static let products = [
        ProductItem(
            id: "monge-cat-salmon-1500",
            name: "ЛУМПИКО",
            description: "Корм для стерилизованных кошек",
            details: "Полнорационный корм для взрослых стерилизованных кошек.",
            animalType: .cat,
            categoryID: "cat-food",
            price: 1890,
            taste: "Лосось",
            weight: 1.5,
            imageURL: imageURL,
            rating: 4.8,
            discount: 17
        ),
        ProductItem(
            id: "lapka-dog-lamb-3000",
            name: "Лапка",
            description: "Корм для взрослых собак",
            details: "Полнорационный корм с ягнёнком и рисом для взрослых собак.",
            animalType: .dog,
            categoryID: "dog-food",
            price: 3290,
            taste: "Ягнёнок и рис",
            weight: 3,
            imageURL: imageURL,
            rating: 4.7
        )
    ]
    
    // MARK: - Public Methods

    func loadProducts() -> AnyPublisher<[ProductItem], Error> {
        Just(Self.products)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
#endif
