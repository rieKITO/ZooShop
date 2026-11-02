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

    private static let storeRepository: any StoreRepository = RemoteStoreRepository(
        storesURL: APIConfiguration.storesURL
    )

    private static let productRepository: any ProductRepository = RemoteProductRepository(
        productsURL: APIConfiguration.productsURL
    )

    private static let favoritesService: Result<any FavoritesService, Error> = Result {
        try CoreDataFavoritesService()
    }

    static func makeStoresViewModel() -> StoresViewModel {
        StoresViewModel(repository: storeRepository)
    }

    static func makeCatalogViewModel() -> CatalogViewModel {
        CatalogViewModel(repository: productRepository)
    }

    static func makeFavoritesViewModel() -> FavoritesViewModel {
        switch favoritesService {
        case .success(let service):
            FavoritesViewModel(service: service)
        case .failure(let error):
            FavoritesViewModel(unavailableBecause: error)
        }
    }
}
