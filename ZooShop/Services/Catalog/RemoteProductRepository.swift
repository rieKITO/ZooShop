//
//  RemoteProductRepository.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 10.10.2026.
//

import Foundation

@MainActor
struct RemoteProductRepository: ProductRepository {
    
    // MARK: - Init Properties
    
    let productsURL: URL
    var session: URLSession = .shared
    
    // MARK: - Public Methods

    func loadProducts() async throws -> [ProductItem] {
        var request = URLRequest(url: productsURL)
        request.timeoutInterval = 15
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200..<300).contains(response.statusCode) else {
            throw NetworkError.httpStatus(response.statusCode)
        }
        let products = try JSONDecoder().decode([ProductItem].self, from: data)
        guard Set(products.map(\.id)).count == products.count,
              products.allSatisfy({ !$0.id.isEmpty }) else {
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
