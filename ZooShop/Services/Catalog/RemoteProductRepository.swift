//
//  RemoteProductRepository.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 10.10.2026.
//

import Combine
import Foundation

@MainActor
struct RemoteProductRepository: ProductRepository {
    
    // MARK: - Init Properties
    
    let productsURL: URL
    var session: URLSession = .shared
    
    // MARK: - Public Methods

    func loadProducts() -> AnyPublisher<[ProductItem], Error> {
        var request = URLRequest(url: productsURL)
        request.timeoutInterval = 15
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        return session.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.global(qos: .userInitiated))
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                guard (200..<300).contains(response.statusCode) else {
                    throw NetworkError.httpStatus(response.statusCode)
                }
                return output.data
            }
            .decode(type: [ProductItem].self, decoder: JSONDecoder())
            .tryMap { products in
                guard
                    Set(products.map(\.id)).count == products.count,
                    products.allSatisfy({ !$0.id.isEmpty })
                else {
                    throw NetworkError.invalidIdentifiers
                }
                guard products.allSatisfy({
                    $0.rating.isFinite && (0...5).contains($0.rating)
                        && ["http", "https"].contains($0.imageURL.scheme?.lowercased() ?? "")
                        && $0.imageURL.host != nil
                }) else {
                    throw NetworkError.invalidProductData
                }
                return products
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Error

    enum NetworkError: LocalizedError {
        case invalidResponse
        case httpStatus(Int)
        case invalidIdentifiers
        case invalidProductData

        var errorDescription: String? {
            switch self {
            case .invalidIdentifiers:
                return String(localized: "Catalog.error.invalidIdentifiers")
            case .invalidProductData:
                return String(localized: "Catalog.error.invalidProductData")
            case .invalidResponse:
                return String(localized: "Catalog.error.invalidResponse")
            case .httpStatus(let status):
                return String(format: String(localized: "Catalog.error.httpStatus"), status)
            }
        }
    }

}
