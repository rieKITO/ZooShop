//
//  MainSectionView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 06.10.2026.
//

import SwiftUI

struct MainSectionView: View {
    
    // MARK: - Init Properties
    
    let viewModel: MainSectionViewModel

    private let cards: [InfoCard] = [
        InfoCard(
            tag: "Осень с заботой",
            title: "Большая забота. Маленькая цена.",
            description: "До -20% на любимый корм для вашего питомца.",
            backgroundColor: Colors.Decorative.promoPeach.swiftUIColor,
            image: Image("dogCutout")
        ),
        InfoCard(
            tag: "Для уютного дома",
            title: "Уют для любимого питомца.",
            description: "Лежанки, игрушки и всё для счастливых дней дома.",
            backgroundColor: Colors.Decorative.promoSage.swiftUIColor,
            image: Image("hamsterCutout")
        ),
        InfoCard(
            tag: "Каждый день вместе",
            title: "Время для прогулки!",
            description: "Подберите аксессуары для прогулок с вашим другом.",
            backgroundColor: Colors.Decorative.articleMist.swiftUIColor,
            image: Image("catCutout")
        )
    ]
    
    // MARK: - State

    @State
    private var selectedProduct: ProductItem?

    // MARK: - Body

    var body: some View {
        ZStack {
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    title
                        .frame(maxWidth: .infinity, alignment: .leading)
                    infoCards
                        .padding(.top, 8)
                    favoriteProducts
                        .padding(.top, 24)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            }
            .scrollClipDisabled()
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(item: $selectedProduct) { product in
            ProductDetailsView(product: product, favorites: viewModel.favorites)
        }
        .onAppear {
            viewModel.loadIfNeeded()
        }
    }
}

// MARK: - Subviews

private extension MainSectionView {
    
    @ViewBuilder
    var favoriteProducts: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(L10n.Favorites.title)
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Colors.Content.primary.swiftUIColor)

            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else if let catalogError = viewModel.errorMessage {
                ErrorStateView(
                    title: L10n.Catalog.Error.title,
                    description: catalogError,
                    buttonLabel: L10n.Common.retry
                ) {
                    viewModel.retry()
                }
            } else if viewModel.favoriteProducts.isEmpty {
                Text(L10n.Favorites.empty)
                    .foregroundStyle(Colors.Content.secondary.swiftUIColor)
            } else {
                LazyVGrid(
                    columns:
                        [
                            GridItem(.flexible(), alignment: .top),
                            GridItem(.flexible(), alignment: .top)
                        ],
                    spacing: 20
                ) {
                    ForEach(viewModel.favoriteProducts) { product in
                        ProductItemView(
                            product: product,
                            isFavorite: viewModel.favorites.contains(product.id),
                            isFavoriteEnabled: viewModel.favorites.isAvailable,
                            onSelect: { selectedProduct = product }
                        ) {
                            viewModel.toggleFavorite(product.id)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 24)
    }

    var title: some View {
        HStack(spacing: 0) {
            Image(systemName: "pawprint.fill")
                .font(.title2)
                .frame(height: 70)
                .foregroundColor(Colors.Brand.warmAccent.swiftUIColor)
            Text(L10n.Main.title)
                .foregroundStyle(Colors.Content.primary.swiftUIColor)
            Text(".")
                .foregroundStyle(Colors.Brand.warmAccent.swiftUIColor)
        }
        .font(.title)
        .fontWeight(.heavy)
    }
    
    var infoCards: some View {
        InfoCardCarouselView(cards: cards, size: .big)
    }
    
}

// MARK: - Preview

#Preview("Light Theme") {
    MainSectionView(
        viewModel: MainSectionViewModel(
            catalog: CatalogViewModel(repository: PreviewProductRepository()),
            favorites: FavoritesViewModel(service: PreviewFavoritesService())
        )
    )
}

#Preview("Dark Theme") {
    MainSectionView(
        viewModel: MainSectionViewModel(
            catalog: CatalogViewModel(repository: PreviewProductRepository()),
            favorites: FavoritesViewModel(service: PreviewFavoritesService())
        )
    )
    .preferredColorScheme(.dark)
}
