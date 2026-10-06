import SwiftUI

enum HomeTab: CaseIterable, TabBarItem {
    case main
    case catalog
    case shops
    case more

    var title: String {
        switch self {
        case .main: return L10n.TabBar.Category.main
        case .catalog: return L10n.TabBar.Category.catalog
        case .shops: return L10n.TabBar.Category.shops
        case .more: return L10n.TabBar.Category.more
        }
    }

    var icon: String {
        switch self {
        case .main: return "house"
        case .catalog: return "basket"
        case .shops: return "map"
        case .more: return "ellipsis"
        }
    }

    var color: Color {
        Colors.Content.accent.swiftUIColor
    }
}
