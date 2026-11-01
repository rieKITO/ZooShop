import Foundation

enum APIConfiguration {
    static let baseURL: URL = {
        guard
            let url = URL(string: "http://localhost:8080"),
            let scheme = url.scheme,
            ["http", "https"].contains(scheme),
            url.host != nil
        else {
            preconditionFailure("Invalid base URL in APIConfiguration")
        }
        return url
    }()

    static var storesURL: URL {
        baseURL.appendingPathComponent("stores", isDirectory: true)
    }

    static var productsURL: URL {
        baseURL.appendingPathComponent("products", isDirectory: true)
    }
}
