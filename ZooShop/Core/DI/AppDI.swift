//
//  AppDI.swift
//  ZooShop
//
// Created by Aleksandr Potemkin on 13.10.2026.
//

import Foundation

@MainActor
enum AppDI {

    // MARK: - App Dependencies

    static let imageLoader: any ImageLoading = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = 30
        return RemoteImageLoader(
            session: URLSession(configuration: configuration),
            diskCache: ImageDiskCache()
        )
    }()

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
