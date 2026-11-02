import Combine
import Foundation
import Observation

@MainActor
@Observable
final class CatalogViewModel {
    
    // MARK: - Private(set) Properties
    
    private(set) var products: [ProductItem] = []
    private(set) var errorMessage: String?
    private(set) var isLoading = true
    
    // MARK: - Observation Ignored
    
    @ObservationIgnored
    private let repository: any ProductRepository
    
    @ObservationIgnored
    private var hasLoaded = false

    @ObservationIgnored
    private var loadingSubscription: AnyCancellable?

    @ObservationIgnored
    private var refreshContinuations: [CheckedContinuation<Void, Never>] = []
    
    // MARK: - Initialization

    init(repository: any ProductRepository) {
        self.repository = repository
    }
    
    // MARK: - Public Methods

    func loadIfNeeded() {
        guard !hasLoaded else {
            return
        }

        loadProducts()
    }

    /// Waits for the active request, or starts a refresh if none is running.
    func refresh() async {
        await withCheckedContinuation { continuation in
            refreshContinuations.append(continuation)
            loadProducts()
        }
    }

    func loadProducts() {
        guard loadingSubscription == nil else {
            return
        }

        isLoading = true
        errorMessage = nil
        products = []
        hasLoaded = false

        loadingSubscription = repository.loadProducts()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else {
                    return
                }

                isLoading = false
                loadingSubscription = nil

                if case .failure(let error) = completion {
                    errorMessage = error.localizedDescription
                }

                let continuations = refreshContinuations
                refreshContinuations.removeAll()
                for continuation in continuations {
                    continuation.resume()
                }
            } receiveValue: { [weak self] products in
                self?.products = products
                self?.hasLoaded = true
            }
    }

}
