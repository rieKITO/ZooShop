//
//  SettingsView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 25.10.2026.
//

import SwiftUI

struct SettingsView: View {

    // MARK: - State

    @State
    private var isPrivacyPresented = false

    // MARK: - Environment

    @Environment(AppThemeManager.self)
    private var appThemeManager

    @Environment(\.tabBarContentInset)
    private var tabBarContentInset

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                appearanceSection
                applicationSection
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 24)
        }
        .contentMargins(.bottom, tabBarContentInset, for: .scrollContent)
        .background(
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()
        )
        .navigationTitle(L10n.More.settings)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isPrivacyPresented) {
            PrivacySheetView()
        }
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

    var appearanceSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionTitle(L10n.Settings.Appearance.title)
            appearanceOptions
        }
    }

    var applicationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionTitle(L10n.Settings.Application.title)

            ListGroupView(rows: [
                ListRowView(
                    title: L10n.Settings.Application.version,
                    showsChevron: false,
                    value: AppInfo.version
                ),
                Button {
                    isPrivacyPresented = true
                } label: {
                    ListRowView(title: L10n.Settings.Privacy.title)
                }
            ])
        }
    }

    func sectionTitle(_ title: String) -> some View {
        Text(title.uppercased())
            .font(.caption)
            .tracking(1.5)
            .foregroundStyle(Colors.Content.secondary.swiftUIColor)
            .padding(.horizontal, 4)
            .accessibilityAddTraits(.isHeader)
    }

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
    NavigationStack {
        SettingsView()
            .environment(AppThemeManager())
    }
}

#Preview("Dark Theme") {
    NavigationStack {
        SettingsView()
            .environment(AppThemeManager())
    }
    .preferredColorScheme(.dark)
}
