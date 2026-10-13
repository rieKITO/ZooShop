//
//  AppDI.swift
//  ZooShop
//
// Created by Aleksandr Potemkin on 13.10.2026.
//

@MainActor
enum AppDI {

    // MARK: - App Dependencies

    static func makeMainSectionViewModel() -> MainSectionViewModel {
        let favorites: FavoritesViewModel
        do {
            favorites = FavoritesViewModel(service: try CoreDataFavoritesService())
        } catch {
            favorites = FavoritesViewModel(unavailableBecause: error)
        }

        return MainSectionViewModel(
            catalog: CatalogViewModel(repository: RemoteProductRepository(
                productsURL: ProductAPIConfiguration.productsURL
            )),
            favorites: favorites
        )
    }
}
