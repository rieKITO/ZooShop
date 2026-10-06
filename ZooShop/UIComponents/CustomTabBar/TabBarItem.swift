import SwiftUI

/// The presentation data required by `CustomTabBarView`
protocol TabBarItem: Hashable {
    var title: String { get }
    var icon: String { get }
    var color: Color { get }
}
