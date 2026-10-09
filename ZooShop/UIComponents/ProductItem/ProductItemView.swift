//
//  ProductItemView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 07.10.2026.
//

import SwiftUI

struct ProductItemView: View {
    
    // MARK: - Init Properties
    
    @Binding
    var product: ProductItem
    
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
                product.image
                    .resizable()
                    .scaledToFit()
                    .padding(20)
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

    var favoriteButton: some View {
        Button {
            product.isFavorite.toggle()
        } label: {
            Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(
                    product.isFavorite
                        ? Colors.Brand.primary.swiftUIColor
                        : Colors.Content.secondary.swiftUIColor
                )
                .frame(width: 36, height: 36)
                .background(Colors.Backgrounds.canvas.swiftUIColor, in: Circle())
                .frame(width: 44, height: 44)
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
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

private struct ProductItemsPreview: View {

    @State
    private var discountedProduct = ProductItem(
        name: "MONGe",
        description: "Корм для стерилизованных кошек",
        price: 1890000,
        taste: "Лосось",
        weight: 1.5,
        image: Image("catCutout"),
        isFavorite: true,
        discount: 17
    )
    
    @State
    private var regularProduct = ProductItem(
        name: "GRANDORF",
        description: "Корм для взрослых собак",
        price: 1890,
        taste: "Ягненок и рис",
        weight: 3,
        image: Image("dogCutout")
    )

    var body: some View {
        ZStack {
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()

            HStack(alignment: .top, spacing: 16) {
                ProductItemView(product: $discountedProduct)
                ProductItemView(product: $regularProduct)
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
