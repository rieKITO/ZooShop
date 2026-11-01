import Combine

@MainActor
protocol StoreRepository {
    func loadStores() -> AnyPublisher<[Store], Error>
}
