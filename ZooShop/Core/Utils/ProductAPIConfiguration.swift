//
//  ProductAPIConfiguration.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 10.10.2026.
//

import Foundation

enum ProductAPIConfiguration {
    static let baseURL: URL = {
        guard
            let url = URL(string: "http://localhost:8080"),
            let scheme = url.scheme,
            ["http", "https"].contains(scheme),
            url.host != nil
        else {
            preconditionFailure("Invalid base URL in ProductAPIConfiguration")
        }
        return url
    }()

    static var productsURL: URL {
        baseURL.appendingPathComponent("products", isDirectory: true)
    }
}
