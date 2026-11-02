import Foundation
import Observation

@MainActor
@Observable
final class FavoritesViewModel {
    
    // MARK: - Private(set) Properties
    
    private(set) var productIDs: Set<String> = []
    private(set) var isAvailable = false
    
    // MARK: - Public Properties
    
    var errorMessage: String?
    
    // MARK: - Observation Ignored

    @ObservationIgnored
    private let service: (any FavoritesService)?
    
    @ObservationIgnored
    private var hasAttemptedLoad = false

    // MARK: - Initialization

    init(service: any FavoritesService) {
        self.service = service
    }

    init(unavailableBecause error: Error) {
        service = nil
        errorMessage = error.localizedDescription
    }

    // MARK: - Public Methods

    func loadIfNeeded() {
        guard !hasAttemptedLoad, let service else {
            return
        }
        hasAttemptedLoad = true

        do {
            productIDs = try service.fetchProductIDs()
            isAvailable = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func contains(_ productID: String) -> Bool {
        productIDs.contains(productID)
    }

    func toggle(_ productID: String) {
        guard
            isAvailable,
            let service
        else {
            return
        }

        let newValue = !contains(productID)
        do {
            try service.setFavorite(newValue, productID: productID)
            
            if newValue {
                productIDs.insert(productID)
            } else {
                productIDs.remove(productID)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

}
