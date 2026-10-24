//
//  ImageLoading.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 22.10.2026.
//

import Combine
import Foundation
import UIKit

@MainActor
protocol ImageLoading {
    func image(for url: URL) -> AnyPublisher<UIImage, Error>
}
