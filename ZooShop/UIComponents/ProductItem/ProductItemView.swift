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
    var image: Image? = nil
    let onToggleFavorite: () -> Void
    
    // MARK: - State

    @State
    private var imageReloadID = UUID()

    
    // MARK: - Computed Properties

    private var discountedPrice: Double {
        guard let discount = product.discount else {
            return product.price
        }

        return product.price * (1 - Double(discount) / 100)
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            productImage
            productPrice
                .padding(.top, 8)
            productInfo
            productTasteAndWeight
        }
    }

}

// MARK: - Subviews

private extension ProductItemView {
    
    var productImage: some View {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
            .fill(Colors.Backgrounds.surface.swiftUIColor)
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                productImageContent
            }
            .overlay(alignment: .topLeading) {
                if let discount = product.discount, discount > 0 {
                    Text("−\(discount)%")
                        .font(.caption2.bold())
                        .foregroundStyle(Colors.States.saleForeground.swiftUIColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Colors.States.saleBackground.swiftUIColor)
                        }
                        .padding(10)
                }
            }
            .overlay(alignment: .topTrailing) {
                favoriteButton
                    .padding(6)
            }
    }

    @ViewBuilder
    var productImageContent: some View {
        if let image {
            image
                .resizable()
                .scaledToFit()
                .padding(20)
                .padding(.top, 10)
        } else {
            remoteProductImage
        }
    }

    var remoteProductImage: some View {
        AsyncImage(url: product.imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                    .padding(.top, 10)
            case .failure:
                Button {
                    imageReloadID = UUID()
                } label: {
                    VStack(spacing: 6) {
                        Image(systemName: "photo.badge.exclamationmark")
                            .font(.title2)
                        Text("Product.image.retry")
                            .font(.caption2)
                    }
                    .foregroundStyle(Colors.Content.secondary.swiftUIColor)
                }
                .buttonStyle(.plain)
            @unknown default:
                Image(systemName: "photo")
            }
        }
        .id(imageReloadID)
    }

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
    
    var productPrice: some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            Text(discountedPrice.formattedCurrency(code: product.currencyCode))
                .font(.callout)
                .fontWeight(.bold)
                
            if
                let discount = product.discount,
                discount > 0
            {
                Text(product.price.formattedCurrency(code: product.currencyCode))
                    .font(.caption)
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

#if DEBUG
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
                ProductItemView(product: discountedProduct, isFavorite: isDiscountedFavorite, image: Image("PreviewProduct")) {
                    isDiscountedFavorite.toggle()
                }
                ProductItemView(product: regularProduct, isFavorite: isRegularFavorite, image: Image("PreviewProduct")) {
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
#endif
