//
//  HomeView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 04.10.2026.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Environment
    
    @Environment(MainSectionViewModel.self)
    private var viewModel
    
    // MARK: - State

    @State
    private var selectedTab: HomeTab = .main
    
    // MARK: - Body

    var body: some View {
        ZStack {
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()
            tabContent
                .environment(\.tabBarContentInset, TabBarLayout.height)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            CustomTabBarView(tabs: HomeTab.allCases, selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .alert(L10n.Common.Error.title, isPresented: Binding(
            get: {
                viewModel.favorites.errorMessage != nil
            },
            set: {
                if !$0 {
                    viewModel.favorites.errorMessage = nil
                }
            }
        )) {
            Button(L10n.Common.ok, role: .cancel) { }
        } message: {
            Text(viewModel.favorites.errorMessage ?? "")
        }
    }

}

// MARK: - Subviews

private extension HomeView {
    
    @ViewBuilder
    var tabContent: some View {
        switch selectedTab {
        case .main:
            NavigationStack {
                MainSectionView(
                    viewModel: viewModel,
                    onShowAllPetCategories: { selectedTab = .catalog }
                )
            }
        case .catalog:
            PetCategoriesView(
                viewModel: viewModel.catalog,
                favorites: viewModel.favorites
            )
        case .shops:
            Text(selectedTab.title)
        case .more:
            NavigationStack {
                MoreSectionView()
            }
            .tint(Colors.Content.primary.swiftUIColor)
        }
    }
    
}

// MARK: - Preview

#Preview("Light Theme") {
    HomeView()
        .environment(AppThemeManager())
        .environment(MainSectionViewModel(
            catalog: CatalogViewModel(repository: PreviewProductRepository()), favorites: FavoritesViewModel(service: PreviewFavoritesService())
        ))
}

#Preview("Dark Theme") {
    HomeView()
        .environment(AppThemeManager())
        .environment(MainSectionViewModel(
            catalog: CatalogViewModel(repository: PreviewProductRepository()), favorites: FavoritesViewModel(service: PreviewFavoritesService())
        ))
        .preferredColorScheme(.dark)
}
