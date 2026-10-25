//
//  CatalogView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 11.10.2026.
//

import SwiftUI

struct CatalogView: View {

    enum Filter {
        case all
        case animal(ProductItem.AnimalType)
        case favorites
    }
    
    @Environment(\.tabBarContentInset)
    private var tabBarContentInset

    // MARK: - Init Properties
    
    let viewModel: CatalogViewModel
    let favorites: FavoritesViewModel
    var filter: Filter = .all
    
    // MARK: - State

    @State
    private var selectedProduct: ProductItem?

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
                                minHeight: max(0, geometry.size.height - tabBarContentInset - 32),
                                alignment: viewModel.errorMessage != nil && !viewModel.isLoading ? .center : .top
                            )
                            .padding(.horizontal, 16)
                            .padding(.top, 24)
                            .padding(.bottom, 8)
                    }
                    .contentMargins(.bottom, tabBarContentInset, for: .scrollContent)
                }
            }
            .foregroundStyle(Colors.Content.primary.swiftUIColor)
            .onAppear {
                viewModel.loadIfNeeded()
            }
        }
        .navigationDestination(item: $selectedProduct) { product in
            ProductDetailsView(product: product, favorites: favorites)
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
            Text(emptyMessage)
                .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            productsGrid
        }
    }

    var filteredProducts: [ProductItem] {
        switch filter {
        case .all:
            viewModel.products
        case .animal(let animalType):
            viewModel.products.filter { $0.animalType == animalType }
        case .favorites:
            viewModel.products.filter { favorites.contains($0.id) }
        }
    }

    var emptyMessage: String {
        switch filter {
        case .favorites: L10n.Favorites.empty
        case .all, .animal: L10n.Catalog.empty
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
            ForEach(filteredProducts) { product in
                ProductItemView(
                    product: product,
                    isFavorite: favorites.contains(product.id),
                    isFavoriteEnabled: favorites.isAvailable,
                    onSelect: { selectedProduct = product }
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
