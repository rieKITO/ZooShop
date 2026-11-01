import Combine

@MainActor
protocol ProductRepository {
    func loadProducts() -> AnyPublisher<[ProductItem], Error>
}
