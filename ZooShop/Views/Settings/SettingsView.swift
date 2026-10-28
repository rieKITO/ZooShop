//
//  SettingsView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 25.10.2026.
//

import SwiftUI

struct SettingsView: View {

    // MARK: - Environment

    @Environment(AppThemeManager.self)
    private var appThemeManager

    @Environment(\.tabBarContentInset)
    private var tabBarContentInset

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(L10n.Settings.Appearance.title.uppercased())
                    .font(.caption)
                    .tracking(1.5)
                    .foregroundStyle(Colors.Content.secondary.swiftUIColor)
                    .padding(.horizontal, 4)
                    .accessibilityAddTraits(.isHeader)
                appearanceOptions
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
        }
        .contentMargins(.bottom, tabBarContentInset, for: .scrollContent)
        .background(
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()
        )
        .navigationTitle(L10n.More.settings)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(L10n.More.settings)
                    .font(.headline)
                    .foregroundStyle(Colors.Content.primary.swiftUIColor)
                    .accessibilityAddTraits(.isHeader)
            }
        }
    }
}

// MARK: - Subviews

private extension SettingsView {

    var appearanceOptions: some View {
        ListGroupView(rows:
            AppTheme.allCases.map { theme in
                SelectionRowView(
                    title: theme.displayName,
                    isSelected: appThemeManager.selectedTheme == theme
                ) {
                    appThemeManager.updateTheme(theme)
                }
            }
        )
    }
}

// MARK: - Preview

#Preview("Light Theme") {
    SettingsView()
        .environment(AppThemeManager())
}

#Preview("Dark Theme") {
    SettingsView()
        .environment(AppThemeManager())
        .preferredColorScheme(.dark)
}
