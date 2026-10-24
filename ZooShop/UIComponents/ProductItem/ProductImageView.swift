//
//  ProductImageView.swift
//  ZooShop
//
// Created by Aleksandr Potemkin on 22.10.2026.
//

import SwiftUI

struct ProductImageView: View {

    // MARK: - Init Properties

    let product: ProductItem
    var aspectRatio: CGFloat = 1

    // MARK: - Body

    var body: some View {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
            .fill(Colors.Backgrounds.surface.swiftUIColor)
            .aspectRatio(aspectRatio, contentMode: .fit)
            .overlay {
                remoteProductImage
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
    }

}

// MARK: - Subviews

private extension ProductImageView {

    var remoteProductImage: some View {
        RemoteImageView(url: product.imageURL) { phase, retry in
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
                retryButton(action: retry)
            @unknown default:
                Image(systemName: "photo")
            }
        }
    }

    func retryButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: "photo.badge.exclamationmark")
                    .font(.title2)
                Text(L10n.Product.Image.retry)
                    .font(.caption2)
            }
            .foregroundStyle(Colors.Content.secondary.swiftUIColor)
        }
        .buttonStyle(.plain)
    }

}

// MARK: - Preview

#Preview {
    ZStack {
        Colors.Backgrounds.canvas.swiftUIColor
            .ignoresSafeArea()
        
        ProductImageView(product: PreviewProductRepository.products[0])
            .padding(.horizontal, 16)
    }
}
