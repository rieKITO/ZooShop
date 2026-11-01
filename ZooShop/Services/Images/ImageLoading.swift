import Combine
import Foundation
import UIKit

@MainActor
protocol ImageLoading {
    func image(for url: URL) -> AnyPublisher<UIImage, Error>
}
