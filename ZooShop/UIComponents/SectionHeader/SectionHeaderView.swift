//
//  SectionHeaderView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 25.10.2026.
//

import SwiftUI

struct SectionHeaderView: View {

    // MARK: - Init Properties

    let title: String
    var onShowAll: (() -> Void)? = nil

    // MARK: - Body

    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Colors.Content.primary.swiftUIColor)
                .accessibilityAddTraits(.isHeader)
            Spacer(minLength: 8)
            if let onShowAll {
                Button(action: onShowAll) {
                    HStack(spacing: 4) {
                        Text(L10n.Common.all)
                        Image(systemName: "chevron.right")
                            .font(.caption)
                    }
                    .font(.subheadline)
                    .foregroundStyle(Colors.Content.accent.swiftUIColor)
                    .frame(minHeight: 44)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
    }
}

// MARK: - Preview

#Preview("With action") {
    SectionHeaderView(title: L10n.PetCategories.title, onShowAll: { })
        .padding()
}

#Preview("Title only") {
    SectionHeaderView(title: L10n.Favorites.title)
        .padding()
}

#Preview("Dark Theme") {
    SectionHeaderView(title: L10n.PetCategories.title, onShowAll: { })
        .padding()
        .preferredColorScheme(.dark)
}
