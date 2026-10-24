//
//  ProductItem.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 07.10.2026.
//

import Foundation

struct ProductItem: Identifiable, Codable, Hashable {
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
        
        var catalogTitle: String {
            switch self {
            case .dog: L10n.PetCategories.Dog.title
            case .cat: L10n.PetCategories.Cat.title
            case .smallPet: L10n.PetCategories.SmallPet.title
            case .bird: L10n.PetCategories.Bird.title
            }
        }

        var catalogSubtitle: String {
            switch self {
            case .dog: L10n.PetCategories.Dog.subtitle
            case .cat: L10n.PetCategories.Cat.subtitle
            case .smallPet: L10n.PetCategories.SmallPet.subtitle
            case .bird: L10n.PetCategories.Bird.subtitle
            }
        }

        var emojiImageName: String {
            switch self {
            case .dog: "animalDogEmoji"
            case .cat: "animalCatEmoji"
            case .smallPet: "animalRodentEmoji"
            case .bird: "animalBirdEmoji"
            }
        }
    }
}
