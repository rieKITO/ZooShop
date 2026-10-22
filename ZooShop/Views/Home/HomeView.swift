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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, spacing: 0) {
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
            MainSectionView(viewModel: viewModel)
        case .catalog:
            PetCategoriesView(
                viewModel: viewModel.catalog,
                favorites: viewModel.favorites
            )
        case .shops, .more:
            Text(selectedTab.title)
        }
    }
    
}

// MARK: - Preview

#Preview("Light Theme") {
    HomeView()
        .environment(MainSectionViewModel(
            catalog: CatalogViewModel(repository: PreviewProductRepository()), favorites: FavoritesViewModel(service: PreviewFavoritesService())
        ))
}

#Preview("Dark Theme") {
    HomeView()
        .environment(MainSectionViewModel(
            catalog: CatalogViewModel(repository: PreviewProductRepository()), favorites: FavoritesViewModel(service: PreviewFavoritesService())
        ))
        .preferredColorScheme(.dark)
}
