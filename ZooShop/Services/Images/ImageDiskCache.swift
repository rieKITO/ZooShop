//
//  ImageDiskCache.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 22.10.2026.
//

import CryptoKit
import Foundation
import OSLog

nonisolated final class ImageDiskCache: @unchecked Sendable {

    // MARK: - Private Properties

    // All file operations are serialized, including access to FileManager.
    private let queue = DispatchQueue(label: "ZooShop.ImageDiskCache")
    private let directory: URL
    private let fileManager = FileManager.default
    private let logger = Logger(subsystem: "ZooShop", category: "ImageDiskCache")

    // MARK: - Initialization

    init(
        directory: URL = URL.cachesDirectory.appending(path: "ProductImages", directoryHint: .isDirectory)
    ) {
        self.directory = directory
    }

    // MARK: - Public Methods

    func data(for url: URL) -> Data? {
        queue.sync {
            try? Data(contentsOf: fileURL(for: url))
        }
    }

    func save(_ data: Data, for url: URL) {
        queue.sync {
            do {
                try fileManager.createDirectory(at: directory, withIntermediateDirectories: true)
                try data.write(to: fileURL(for: url), options: .atomic)
            } catch {
                logger.error("Failed to cache image: \(error.localizedDescription)")
            }
        }
    }

    func remove(for url: URL) {
        queue.sync {
            try? fileManager.removeItem(at: fileURL(for: url))
        }
    }
}

// MARK: - File URL

private extension ImageDiskCache {

    nonisolated func fileURL(for url: URL) -> URL {
        let hash = SHA256.hash(data: Data(url.absoluteString.utf8))
            .map { String(format: "%02x", $0) }
            .joined()
        return directory.appending(path: hash).appendingPathExtension("image")
    }

}
