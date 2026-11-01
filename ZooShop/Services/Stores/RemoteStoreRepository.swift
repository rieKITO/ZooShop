//
//  RemoteStoreRepository.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 10.10.2026.
//

import Combine
import Foundation

@MainActor
struct RemoteStoreRepository: StoreRepository {
    
    // MARK: - Init Properties
    
    let storesURL: URL
    var session: URLSession = .shared
    
    // MARK: - Public Methods

    func loadStores() -> AnyPublisher<[Store], Error> {
        var request = URLRequest(url: storesURL)
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
            .decode(type: [Store].self, decoder: JSONDecoder())
            .tryMap { stores in
                guard
                    Set(stores.map(\.id)).count == stores.count,
                    stores.allSatisfy({ !$0.id.isEmpty })
                else {
                    throw NetworkError.invalidIdentifiers
                }
                return stores
            }
            .mapError { error in
                error is DecodingError ? NetworkError.invalidData : error
            }
            .eraseToAnyPublisher()
    }

}
