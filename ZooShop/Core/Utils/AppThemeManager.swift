//
//  AppThemeManager.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 25.10.2026.
//

import Observation
import SwiftUI

@MainActor
@Observable
final class AppThemeManager {

    // MARK: - Properties

    private(set) var selectedTheme: AppTheme

    private let userDefaults: UserDefaults
    private static let appThemeKey = "appTheme"

    // MARK: - Computed Properties

    var colorScheme: ColorScheme? {
        switch selectedTheme {
        case .light: .light
        case .dark: .dark
        case .system: nil
        }
    }

    // MARK: - Init

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        let savedTheme = userDefaults.string(forKey: Self.appThemeKey)
        selectedTheme = savedTheme.flatMap(AppTheme.init(rawValue:)) ?? .system
    }

    // MARK: - Public Methods

    func updateTheme(_ theme: AppTheme) {
        selectedTheme = theme
        userDefaults.set(theme.rawValue, forKey: Self.appThemeKey)
    }
}
