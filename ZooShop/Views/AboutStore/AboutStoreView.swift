//
//  AboutStoreView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 28.10.2026.
//

import SwiftUI

struct AboutStoreView: View {

    // MARK: - Init Properties

    let onShowShops: () -> Void

    // MARK: - Environment

    @Environment(\.tabBarContentInset)
    private var tabBarContentInset

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                brandHeader
                    .padding(.bottom, 12)
                introduction
                storeFacts
                contacts
                Text(L10n.AboutStore.disclaimer)
                    .font(.footnote)
                    .foregroundStyle(Colors.Content.secondary.swiftUIColor)
                    .lineSpacing(4)
            }
            .padding(.horizontal, 16)
            .padding(.top, 32)
            .padding(.bottom, 24)
        }
        .scrollIndicators(.hidden)
        .contentMargins(.bottom, tabBarContentInset, for: .scrollContent)
        .background(Colors.Backgrounds.canvas.swiftUIColor.ignoresSafeArea())
        .navigationTitle(L10n.AboutStore.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(L10n.AboutStore.title)
                    .font(.headline)
                    .foregroundStyle(Colors.Content.primary.swiftUIColor)
                    .accessibilityAddTraits(.isHeader)
            }
        }
    }

}

// MARK: - Subviews

private extension AboutStoreView {

    var brandHeader: some View {
        VStack(spacing: 16) {
            HStack(spacing: 8) {
                Image(systemName: "pawprint.fill")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(Colors.Brand.warmAccent.swiftUIColor)
                Text("\(L10n.Main.title)\(Text(".").foregroundStyle(Colors.Brand.warmAccent.swiftUIColor))")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
            .foregroundStyle(Colors.Content.primary.swiftUIColor)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(L10n.Main.title)
            .minimumScaleFactor(0.5)
            .lineLimit(1)

            Text(L10n.AboutStore.tagline)
                .font(.body)
                .foregroundStyle(Colors.Content.secondary.swiftUIColor)
                .multilineTextAlignment(.center)
                .lineSpacing(6)
        }
        .frame(maxWidth: .infinity)
    }

    var introduction: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image("shopStorefront")
                .resizable()
                .scaledToFit()
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Colors.Backgrounds.accentSoft.swiftUIColor)
                )
                .accessibilityHidden(true)

            Text(L10n.AboutStore.description)
                .font(.body)
                .foregroundStyle(Colors.Content.secondary.swiftUIColor)
                .lineSpacing(6)
        }
    }
    
    var storeFacts: some View {
        FactGroupView(facts: [
            FactCardView(
                value: L10n.AboutStore.Facts.Years.value,
                caption: L10n.AboutStore.Facts.Years.caption,
                systemImage: "leaf"
            ),
            FactCardView(
                value: L10n.AboutStore.Facts.Shops.value,
                caption: L10n.AboutStore.Facts.Shops.caption,
                systemImage: "storefront"
            ),
            FactCardView(
                value: L10n.AboutStore.Facts.Love.value,
                caption: L10n.AboutStore.Facts.Love.caption,
                systemImage: "heart"
            )
        ])
    }

    var contacts: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(title: L10n.AboutStore.Contacts.title)
            ListGroupView(rows: [
                ListRowView(
                    title: L10n.AboutStore.Contacts.phone,
                    systemImage: "phone",
                    showsChevron: false,
                    subtitle: L10n.AboutStore.Contacts.hours
                ),
                ListRowView(
                    title: L10n.AboutStore.Contacts.email,
                    systemImage: "envelope",
                    showsChevron: false,
                    subtitle: L10n.AboutStore.Contacts.emailSubtitle
                ),
                Button(action: onShowShops) {
                    ListRowView(
                        title: L10n.AboutStore.Contacts.addresses,
                        systemImage: "mappin.and.ellipse"
                    )
                }
            ])
            .buttonStyle(.plain)
        }
    }

}

// MARK: - Preview

#Preview("Light Theme") {
    NavigationStack {
        AboutStoreView(onShowShops: {})
    }
}

#Preview("Dark Theme") {
    NavigationStack {
        AboutStoreView(onShowShops: {})
    }
    .preferredColorScheme(.dark)
}
