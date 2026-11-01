//
//  NetworkError.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 30.10.2026.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidResponse
    case httpStatus(Int)
    case invalidIdentifiers
    case invalidData

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return L10n.Network.Error.invalidResponse
        case .httpStatus(let status):
            return L10n.Network.Error.httpStatus(status)
        case .invalidIdentifiers:
            return L10n.Network.Error.invalidIdentifiers
        case .invalidData:
            return L10n.Network.Error.invalidData
        }
    }
}
