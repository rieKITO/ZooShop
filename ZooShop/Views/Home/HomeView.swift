import SwiftUI

struct HomeView: View {

    // MARK: - State

    @State
    private var selectedTab: HomeTab = .main

    @State
    private var storesViewModel: StoresViewModel

    @State
    private var catalog: CatalogViewModel

    @State
    private var favorites: FavoritesViewModel

    // MARK: - Initialization

    init(
        catalog: CatalogViewModel? = nil,
        favorites: FavoritesViewModel? = nil,
        stores: StoresViewModel? = nil
    ) {
        _catalog = State(initialValue: catalog ?? AppDI.makeCatalogViewModel())
        _favorites = State(initialValue: favorites ?? AppDI.makeFavoritesViewModel())
        _storesViewModel = State(initialValue: stores ?? AppDI.makeStoresViewModel())
    }
    
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
        .task {
            favorites.loadIfNeeded()
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .alert(L10n.Common.Error.title, isPresented: Binding(
            get: {
                favorites.errorMessage != nil
            },
            set: {
                if !$0 {
                    favorites.errorMessage = nil
                }
            }
        )) {
            Button(L10n.Common.ok, role: .cancel) { }
        } message: {
            Text(favorites.errorMessage ?? "")
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
                    catalog: catalog,
                    favorites: favorites,
                    onShowAllPetCategories: {
                        selectedTab = .catalog
                    },
                    onShowShops: {
                        selectedTab = .shops
                    }
                )
            }
        case .catalog:
            PetCategoriesView(
                viewModel: catalog,
                favorites: favorites,
                onShowShops: {
                    selectedTab = .shops
                }
            )
        case .shops:
            StoresSectionView(viewModel: storesViewModel)
        case .more:
            NavigationStack {
                MoreSectionView(
                    onShowShops: {
                        selectedTab = .shops
                    }
                )
            }
        }
    }
    
}

// MARK: - Preview

#Preview("Light Theme") {
    HomeView(
        catalog: CatalogViewModel(repository: PreviewProductRepository()),
        favorites: FavoritesViewModel(service: PreviewFavoritesService()),
        stores: StoresViewModel(repository: PreviewStoreRepository())
    )
    .environment(AppThemeManager())
}

#Preview("Dark Theme") {
    HomeView(
        catalog: CatalogViewModel(repository: PreviewProductRepository()),
        favorites: FavoritesViewModel(service: PreviewFavoritesService()),
        stores: StoresViewModel(repository: PreviewStoreRepository())
    )
    .environment(AppThemeManager())
    .preferredColorScheme(.dark)
}
