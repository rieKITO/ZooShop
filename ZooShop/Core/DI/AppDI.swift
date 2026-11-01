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

    static func makeStoresViewModel() -> StoresViewModel {
        StoresViewModel(repository: RemoteStoreRepository(
            storesURL: APIConfiguration.storesURL
        ))
    }

    static func makeMainSectionViewModel() -> MainSectionViewModel {
        let favorites: FavoritesViewModel
        do {
            favorites = FavoritesViewModel(service: try CoreDataFavoritesService())
        } catch {
            favorites = FavoritesViewModel(unavailableBecause: error)
        }

        return MainSectionViewModel(
            catalog: CatalogViewModel(repository: RemoteProductRepository(
                productsURL: APIConfiguration.productsURL
            )),
            favorites: favorites
        )
    }
}
