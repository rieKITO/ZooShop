//
//  PetCategoriesView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 19.10.2026.
//

import SwiftUI

struct PetCategoriesView: View {
    
    @Environment(\.tabBarContentInset)
    private var tabBarContentInset

    // MARK: - Init Properties
    
    let viewModel: CatalogViewModel
    let favorites: FavoritesViewModel
    
    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Colors.Backgrounds.canvas.swiftUIColor
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        titleWithSubtitle
                        categories
                        bottomInfoLabel
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 24)
                }
                .contentMargins(.bottom, tabBarContentInset, for: .scrollContent)
            }
            .navigationDestination(for: ProductItem.AnimalType.self) { animalType in
                CatalogView(
                    viewModel: viewModel,
                    favorites: favorites,
                    filter: .animal(animalType)
                )
                .navigationTitle(animalType.catalogTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(animalType.catalogTitle)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Colors.Content.primary.swiftUIColor)
                            .accessibilityAddTraits(.isHeader)
                    }
                }
            }
        }
    }
}

// MARK: - Subviews

private extension PetCategoriesView {
    
    var titleWithSubtitle: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(L10n.PetCategories.title)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(Colors.Content.primary.swiftUIColor)
            Text(L10n.PetCategories.subtitle)
                .font(.subheadline)
                .foregroundStyle(Colors.Content.secondary.swiftUIColor)
        }
    }
    
    var categories: some View {
        VStack(spacing: 12) {
            ForEach(ProductItem.AnimalType.allCases, id: \.self) { animalType in
                NavigationLink(value: animalType) {
                    AnimalRowView(
                        imageName: animalType.emojiImageName,
                        title: animalType.catalogTitle,
                        subtitle: animalType.catalogSubtitle
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    var bottomInfoLabel: some View {
        Label(L10n.PetCategories.note, systemImage: "leaf")
            .font(.subheadline)
            .foregroundStyle(Colors.Content.accent.swiftUIColor)
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Colors.Backgrounds.accentSoft.swiftUIColor)
            )
    }
    
}

// MARK: - Preview

#Preview("Light Theme") {
    PetCategoriesView(
        viewModel: CatalogViewModel(repository: PreviewProductRepository()),
        favorites: FavoritesViewModel(service: PreviewFavoritesService())
    )
}

#Preview("Dark Theme") {
    PetCategoriesView(
        viewModel: CatalogViewModel(repository: PreviewProductRepository()),
        favorites: FavoritesViewModel(service: PreviewFavoritesService())
    )
    .preferredColorScheme(.dark)
}
