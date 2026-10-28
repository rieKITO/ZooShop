//
//  MainSectionView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 06.10.2026.
//

import SwiftUI

struct MainSectionView: View {
    
    @Environment(\.tabBarContentInset)
    private var tabBarContentInset

    // MARK: - Init Properties
    
    let viewModel: MainSectionViewModel
    let onShowAllPetCategories: () -> Void

    private let petCategories: [ProductItem.AnimalType] = [.dog, .cat, .smallPet, .bird]

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

    @State
    private var showsAllFavorites = false

    // MARK: - Body

    var body: some View {
        ZStack {
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    title
                        .frame(maxWidth: .infinity, alignment: .leading)
                    InfoCardCarouselView(cards: cards, size: .big)
                        .padding(.top, 8)
                    petCategoriesSection
                        .padding(.top, 24)
                    favoriteProducts
                        .padding(.top, 24)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            }
            .contentMargins(.bottom, tabBarContentInset, for: .scrollContent)
            .scrollClipDisabled()
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(item: $selectedProduct) { product in
            ProductDetailsView(product: product, favorites: viewModel.favorites)
        }
        .navigationDestination(for: ProductItem.AnimalType.self) { animalType in
            CatalogView(
                viewModel: viewModel.catalog,
                favorites: viewModel.favorites,
                filter: .animal(animalType)
            )
            .navigationTitle(animalType.catalogTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(animalType.catalogTitle)
                        .font(.headline)
                        .foregroundStyle(Colors.Content.primary.swiftUIColor)
                        .accessibilityAddTraits(.isHeader)
                }
            }
        }
        .navigationDestination(isPresented: $showsAllFavorites) {
            CatalogView(
                viewModel: viewModel.catalog,
                favorites: viewModel.favorites,
                filter: .favorites
            )
            .navigationTitle(L10n.Favorites.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(L10n.Favorites.title)
                        .font(.headline)
                        .foregroundStyle(Colors.Content.primary.swiftUIColor)
                        .accessibilityAddTraits(.isHeader)
                }
            }
        }
        .onAppear {
            viewModel.loadIfNeeded()
        }
    }
}

// MARK: - Subviews

private extension MainSectionView {

    var petCategoriesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: L10n.PetCategories.title,
                onShowAll: onShowAllPetCategories
            )

            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.flexible(), spacing: 12),
                    count: 4),
                spacing: 12) {
                ForEach(petCategories, id: \.self) { animalType in
                    NavigationLink(value: animalType) {
                        VStack(spacing: 8) {
                            ImageInRoundedRectangleView(
                                imageName: animalType.emojiImageName,
                                rectangleBackgroundColor: categoryColor(for: animalType),
                                imageSize: 48,
                                fillsWidth: true
                            )

                            Text(animalType.catalogTitle)
                                .font(.caption)
                                .foregroundStyle(Colors.Content.primary.swiftUIColor)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    func categoryColor(for animalType: ProductItem.AnimalType) -> Color {
        switch animalType {
        case .dog: Colors.Decorative.categoryDog.swiftUIColor
        case .cat: Colors.Decorative.categoryCat.swiftUIColor
        case .smallPet: Colors.Decorative.categorySmallPet.swiftUIColor
        case .bird: Colors.Decorative.categoryBird.swiftUIColor
        }
    }
    
    var favoriteProducts: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(title: L10n.Favorites.title) {
                showsAllFavorites = true
            }

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
                    ForEach(viewModel.favoriteProducts.prefix(2)) { product in
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
        .padding(.bottom, 8)
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
    
}

// MARK: - Preview

#Preview("Light Theme") {
    HomeView()
        .environment(MainSectionViewModel(
            catalog: CatalogViewModel(repository: PreviewProductRepository()),
            favorites: FavoritesViewModel(service: PreviewFavoritesService())
        ))
}

#Preview("Dark Theme") {
    HomeView()
        .environment(MainSectionViewModel(
            catalog: CatalogViewModel(repository: PreviewProductRepository()),
            favorites: FavoritesViewModel(service: PreviewFavoritesService())
        ))
        .preferredColorScheme(.dark)
}
