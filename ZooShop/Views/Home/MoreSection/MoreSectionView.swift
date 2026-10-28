//
//  MoreSectionView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 25.10.2026.
//

import SwiftUI

struct MoreSectionView: View {

    // MARK: - Init Properties

    let onShowShops: () -> Void

    // MARK: - Environment

    @Environment(\.tabBarContentInset)
    private var tabBarContentInset

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text(L10n.More.title)
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundStyle(Colors.Content.primary.swiftUIColor)
                    .accessibilityAddTraits(.isHeader)
                    .padding(.vertical, 20)
                infoCard
                menu
                    .padding(.top, 16)
                footer
                    .padding(.top, 36)
                    .padding(.bottom, 24)
            }
            .padding(.horizontal, 16)
        }
        .contentMargins(.bottom, tabBarContentInset, for: .scrollContent)
        .background(
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()
        )
    }
}

// MARK: - Subviews

private extension MoreSectionView {

    var infoCard: some View {
        InfoCardView(
            card: InfoCard(
                tag: L10n.More.Card.tag,
                title: L10n.More.Card.title,
                description: L10n.More.Card.description,
                backgroundColor: Colors.Backgrounds.accentSoft.swiftUIColor,
                image: Image("dogCutout")
            ),
            size: .small,
            foregroundColor: Colors.Content.primary.swiftUIColor
        )
    }

    var menu: some View {
        ListGroupView(rows: [
            NavigationLink {
                AboutStoreView(onShowShops: onShowShops)
            } label: {
                ListRowView(title: L10n.More.about, systemImage: "info.circle")
            },
            NavigationLink {
                SettingsView()
            } label: {
                ListRowView(title: L10n.More.settings, systemImage: "gearshape")
            }
        ])
    }

    var footer: some View {
        Text("\(Image(systemName: "pawprint.fill")) \(L10n.More.footer)")
            .font(.footnote)
            .foregroundStyle(Colors.Content.secondary.swiftUIColor)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .accessibilityLabel(L10n.More.footer)
    }
}

// MARK: - Preview

#Preview("Light Theme") {
    NavigationStack {
        MoreSectionView(onShowShops: {})
    }
    .environment(AppThemeManager())
}

#Preview("Dark Theme") {
    NavigationStack {
        MoreSectionView(onShowShops: {})
    }
    .environment(AppThemeManager())
    .preferredColorScheme(.dark)
}
