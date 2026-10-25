//
//  ProductDetailsView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 22.10.2026.
//

import SwiftUI

struct ProductDetailsView: View {

    @Environment(\.tabBarContentInset)
    private var tabBarContentInset

    // MARK: - Init Properties

    let product: ProductItem
    let favorites: FavoritesViewModel

    // MARK: - Body

    var body: some View {
        ZStack {
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ProductImageView(product: product, aspectRatio: 1.3)
                    productInfo
                    purchaseActions
                    Text(L10n.Product.Details.priceNote)
                        .font(.footnote)
                        .foregroundStyle(Colors.Content.secondary.swiftUIColor)
                    aboutProduct
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
            }
            .contentMargins(.bottom, tabBarContentInset, for: .scrollContent)
            .scrollIndicators(.hidden)
        }
        .navigationTitle(L10n.Product.Details.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Subviews

private extension ProductDetailsView {

    var productInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(product.name.uppercased())
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundStyle(Colors.Content.secondary.swiftUIColor)
            Text(product.description)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Colors.Content.primary.swiftUIColor)
            Label(product.rating.formattedOneDecimal(), systemImage: "star.fill")
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundStyle(Colors.States.rating.swiftUIColor)

            ProductPriceView(product: product, priceFont: .title, originalPriceFont: .subheadline)
                .padding(.top, 8)
        }
    }

    var purchaseActions: some View {
        VStack(spacing: 16) {
            Button { } label: {
                Label(L10n.Product.Details.whereToBuy, systemImage: "mappin.and.ellipse")
                    .font(.headline)
                    .foregroundStyle(Colors.Content.onAccent.swiftUIColor)
                    .frame(maxWidth: .infinity, minHeight: 62)
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(Colors.Brand.primary.swiftUIColor)
                    )
            }

            HStack(spacing: 8) {
                Button { } label: {
                    Label(L10n.Product.Details.shoppingList, systemImage: "bag")
                        .font(.subheadline)
                        .foregroundStyle(Colors.Content.primary.swiftUIColor)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(actionBackground)
                }

                favoriteButton
            }
        }
        .buttonStyle(.plain)
    }

    var favoriteButton: some View {
        Button {
            favorites.toggle(product.id)
        } label: {
            Image(systemName: favorites.contains(product.id) ? "heart.fill" : "heart")
                .font(.system(size: 20))
                .foregroundStyle(
                    favorites.contains(product.id)
                        ? Colors.Brand.primary.swiftUIColor
                        : Colors.Content.secondary.swiftUIColor
                )
                .frame(width: 48, height: 48)
                .background(actionBackground)
        }
        .disabled(!favorites.isAvailable)
        .accessibilityLabel(Text(favorites.contains(product.id) ? "Favorites.remove" : "Favorites.add"))
    }

    var actionBackground: some View {
        RoundedRectangle(cornerRadius: 14, style: .continuous)
            .fill(Colors.Backgrounds.surface.swiftUIColor)
            .overlay {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .strokeBorder(Colors.Borders.subtle.swiftUIColor, lineWidth: 1)
            }
    }

    var aboutProduct: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text(L10n.Product.Details.about)
                    .font(.title3)
                    .fontWeight(.bold)

                Text(product.details)
                    .font(.body)
                    .foregroundStyle(Colors.Content.secondary.swiftUIColor)
            }

            VStack(spacing: 0) {
                detailRow(title: L10n.Product.Details.animalType, value: product.animalType.catalogTitle)
                detailRow(title: L10n.Product.Details.brand, value: product.name)
                detailRow(title: L10n.Product.Details.taste, value: product.taste)
                detailRow(
                    title: L10n.Product.Details.packageWeight,
                    value: L10n.Product.Details.weight(product.weight.formattedOneDecimal())
                )
            }
        }
        .foregroundStyle(Colors.Content.primary.swiftUIColor)
    }

    func detailRow(title: String, value: String) -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .firstTextBaseline, spacing: 16) {
                Text(title)
                    .foregroundStyle(Colors.Content.secondary.swiftUIColor)
                Spacer()
                Text(value)
                    .multilineTextAlignment(.trailing)
            }
            .font(.subheadline)
            .padding(.vertical, 14)

            Rectangle()
                .fill(Colors.Borders.subtle.swiftUIColor)
                .frame(height: 1)
        }
    }
}

// MARK: - Preview

#Preview("Light Theme") {
    ProductDetailsView(
        product: PreviewProductRepository.products[0],
        favorites: FavoritesViewModel(service: PreviewFavoritesService())
    )
}

#Preview("Dark Theme") {
    ProductDetailsView(
        product: PreviewProductRepository.products[0],
        favorites: FavoritesViewModel(service: PreviewFavoritesService())
    )
    .preferredColorScheme(.dark)
}
