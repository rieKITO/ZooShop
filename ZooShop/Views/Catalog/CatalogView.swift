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
    var animalType: ProductItem.AnimalType? = nil
    
    // MARK: - Body

    var body: some View {
        ZStack {
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                GeometryReader { geometry in
                    ScrollView {
                        catalogContent
                            .frame(maxWidth: .infinity)
                            .frame(
                                minHeight: max(0, geometry.size.height - 24),
                                alignment: viewModel.errorMessage != nil && !viewModel.isLoading ? .center : .top
                            )
                            .padding(.horizontal, 16)
                            .padding(.vertical, 24)
                    }
                }
            }
            .foregroundStyle(Colors.Content.primary.swiftUIColor)
            .onAppear {
                viewModel.loadIfNeeded()
            }
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
                viewModel.loadProducts()
            }
        } else if filteredProducts.isEmpty {
            Text(L10n.Catalog.empty)
                .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            productsGrid
        }
    }

    var filteredProducts: [ProductItem] {
        viewModel.products.filter { animalType == nil || $0.animalType == animalType }
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
            ForEach(filteredProducts) { product in
                ProductItemView(
                    product: product,
                    isFavorite: favorites.contains(product.id),
                    isFavoriteEnabled: favorites.isAvailable
                ) {
                    favorites.toggle(product.id)
                }
            }
        }
    }
    
}

// MARK: - Preview

#Preview("Light Theme") {
    ZStack {
        Colors.Backgrounds.canvas.swiftUIColor
            .ignoresSafeArea()
        
        CatalogView(
            viewModel: CatalogViewModel(repository: PreviewProductRepository()),
            favorites: FavoritesViewModel(service: PreviewFavoritesService())
        )
    }
}

#Preview("Dark Theme") {
    ZStack {
        Colors.Backgrounds.canvas.swiftUIColor
            .ignoresSafeArea()
        
        CatalogView(
            viewModel: CatalogViewModel(repository: PreviewProductRepository()),
            favorites: FavoritesViewModel(service: PreviewFavoritesService())
        )
    }
    .preferredColorScheme(.dark)
}
