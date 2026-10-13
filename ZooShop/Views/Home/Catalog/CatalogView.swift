//
//  CatalogView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 11.10.2026.
//

import SwiftUI

struct CatalogView: View {
    
    // MARK: - Init Properties
    
    let viewModel: CatalogViewModel
    let favorites: FavoritesViewModel
    var productImage: Image? = nil
    
    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(L10n.TabBar.Category.catalog)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 24)

            GeometryReader { geometry in
                ScrollView {
                    catalogContent
                        .frame(maxWidth: .infinity)
                        .frame(
                            minHeight: max(0, geometry.size.height - 24),
                            alignment: viewModel.errorMessage != nil && !viewModel.isLoading ? .center : .top
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom, 24)
                }
                .scrollClipDisabled()
            }
        }
        .foregroundStyle(Colors.Content.primary.swiftUIColor)
        .task {
            await viewModel.loadIfNeeded()
        }
    }
}

// MARK: - Subviews

private extension CatalogView {
    
    @ViewBuilder
    var catalogContent: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if let errorMessage = viewModel.errorMessage {
            ErrorStateView(
                title: L10n.Catalog.Error.title,
                description: errorMessage,
                buttonLabel: L10n.Common.retry
            ) {
                Task { await viewModel.loadProducts() }
            }
        } else if viewModel.products.isEmpty {
            Text(L10n.Catalog.empty)
                .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            productsGrid
        }
    }

    var productsGrid: some View {
        LazyVGrid(
            columns:
                [
                    GridItem(.flexible(), alignment: .top),
                    GridItem(.flexible(), alignment: .top)
                ],
            spacing: 20
        ) {
            ForEach(viewModel.products) { product in
                ProductItemView(
                    product: product,
                    isFavorite: favorites.contains(product.id),
                    isFavoriteEnabled: favorites.isAvailable,
                    image: productImage
                ) {
                    favorites.toggle(product.id)
                }
            }
        }
    }
    
}

// MARK: - Preview

#if DEBUG
#Preview("Light Theme") {
    ZStack {
        Colors.Backgrounds.canvas.swiftUIColor
            .ignoresSafeArea()
        
        CatalogView(
            viewModel: CatalogViewModel(repository: PreviewProductRepository()),
            favorites: FavoritesViewModel(service: PreviewFavoritesService()),
            productImage: Image("PreviewProduct")
        )
    }
}

#Preview("Dark Theme") {
    ZStack {
        Colors.Backgrounds.canvas.swiftUIColor
            .ignoresSafeArea()
        
        CatalogView(
            viewModel: CatalogViewModel(repository: PreviewProductRepository()),
            favorites: FavoritesViewModel(service: PreviewFavoritesService()),
            productImage: Image("PreviewProduct")
        )
    }
    .preferredColorScheme(.dark)
}
#endif
