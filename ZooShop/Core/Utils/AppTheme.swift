import Foundation

enum AppTheme: String, CaseIterable, Identifiable {
    case light
    case dark
    case system

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .light: L10n.Settings.Appearance.light
        case .dark: L10n.Settings.Appearance.dark
        case .system: L10n.Settings.Appearance.system
        }
    }
}
