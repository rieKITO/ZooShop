//
//  ProductItem.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 07.10.2026.
//

import SwiftUI

/// The presentation data required by `ProductItemView`.
struct ProductItem {
    var name: String
    var description: String
    var price: Double
    var taste: String
    var weight: Double
    var image: Image
    var isFavorite: Bool = false
    var discount: Int? = nil
    var currencyCode: String = "RUB"
}
