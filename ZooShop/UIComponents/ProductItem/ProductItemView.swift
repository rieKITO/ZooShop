//
//  ProductItemView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 07.10.2026.
//

import SwiftUI

struct ProductItemView: View {
    
    // MARK: - Init Properties
    
    let product: ProductItem
    let isFavorite: Bool
    var isFavoriteEnabled: Bool = true
    let onToggleFavorite: () -> Void
    
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ProductImageView(product: product)
            ProductPriceView(product: product)
                .padding(.top, 8)
            productInfo
            productTasteAndWeight
        }
        .overlay(alignment: .topTrailing) {
            favoriteButton
                .padding(6)
        }
    }

}

// MARK: - Subviews

private extension ProductItemView {
    
    var favoriteButton: some View {
        Button {
            onToggleFavorite()
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(
                    isFavorite
                        ? Colors.Brand.primary.swiftUIColor
                        : Colors.Content.secondary.swiftUIColor
                )
                .frame(width: 36, height: 36)
                .background(Colors.Backgrounds.canvas.swiftUIColor, in: Circle())
                .frame(width: 44, height: 44)
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .disabled(!isFavoriteEnabled)
        .accessibilityLabel(Text(isFavorite ? "Favorites.remove" : "Favorites.add"))
    }
    
    var productInfo: some View {
        Group {
            Text(product.name)
            Text(product.description)
        }
        .font(.caption)
        .fontWeight(.medium)
        .foregroundStyle(Colors.Content.primary.swiftUIColor)
    }
    
    var productTasteAndWeight: some View {
        Text("\(product.taste) • \(product.weight.formattedOneDecimal()) кг.")
            .font(.caption2)
            .foregroundStyle(Colors.Content.secondary.swiftUIColor)
    }
    
}

// MARK: - Preview

private struct ProductItemsPreview: View {

    @State
    private var isDiscountedFavorite = true
    
    @State
    private var isRegularFavorite = false

    private let discountedProduct = PreviewProductRepository.products[0]
    private let regularProduct = PreviewProductRepository.products[1]

    var body: some View {
        ZStack {
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()

            HStack(alignment: .top, spacing: 16) {
                ProductItemView(product: discountedProduct, isFavorite: isDiscountedFavorite) {
                    isDiscountedFavorite.toggle()
                }
                ProductItemView(product: regularProduct, isFavorite: isRegularFavorite) {
                    isRegularFavorite.toggle()
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview("Light Theme") {
    ProductItemsPreview()
}

#Preview("Dark Theme") {
    ProductItemsPreview()
        .preferredColorScheme(.dark)
}
