//
//  ProductItem.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 07.10.2026.
//

import Foundation

struct ProductItem: Identifiable, Codable {
    let id: String
    var name: String
    var description: String
    var details: String
    var animalType: AnimalType
    var categoryID: String
    var price: Double
    var taste: String
    var weight: Double
    var imageURL: URL
    var rating: Double
    var discount: Int? = nil
    var currencyCode: String = "RUB"
}

extension ProductItem {
    enum AnimalType: String, Codable, CaseIterable {
        case cat
        case dog
        case bird
        case smallPet
    }
}
