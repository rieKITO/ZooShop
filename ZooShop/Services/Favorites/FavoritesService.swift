import Foundation

@MainActor
protocol FavoritesService {
    func fetchProductIDs() throws -> Set<String>
    func setFavorite(_ isFavorite: Bool, productID: String) throws
}
