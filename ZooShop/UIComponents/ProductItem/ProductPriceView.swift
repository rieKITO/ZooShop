//
//  ProductPriceView.swift
//  ZooShop
//
// Created by Aleksandr Potemkin on 22.10.2026.
//

import SwiftUI

struct ProductPriceView: View {

    // MARK: - Init Properties

    let product: ProductItem
    var priceFont: Font = .callout
    var originalPriceFont: Font = .caption

    // MARK: - Computed Properties

    private var discountedPrice: Double {
        guard let discount = product.discount else {
            return product.price
        }

        return product.price * (1 - Double(discount) / 100)
    }

    // MARK: - Body

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            Text(discountedPrice.formattedCurrency(code: product.currencyCode))
                .font(priceFont)
                .fontWeight(.bold)
                .foregroundStyle(Colors.Content.primary.swiftUIColor)

            if let discount = product.discount, discount > 0 {
                Text(product.price.formattedCurrency(code: product.currencyCode))
                    .font(originalPriceFont)
                    .fontWeight(.regular)
                    .strikethrough()
                    .foregroundStyle(Colors.Content.secondary.swiftUIColor)
            }
        }
        .lineLimit(1)
        .minimumScaleFactor(0.5)
        .allowsTightening(true)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview

#Preview {
    ProductPriceView(product: PreviewProductRepository.products[0])
        .padding(.horizontal, 16)
}
