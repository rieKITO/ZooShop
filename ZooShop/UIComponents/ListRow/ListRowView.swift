//
//  ListRowView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 25.10.2026.
//

import SwiftUI

struct ListRowView: ListGroupContent {

    // MARK: - Init Properties

    let title: String
    let systemImage: String
    var showsChevron: Bool = true
    var subtitle: String? = nil
    
    // MARK: - Body

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundStyle(Colors.Content.accent.swiftUIColor)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .foregroundStyle(Colors.Content.primary.swiftUIColor)

                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(Colors.Content.secondary.swiftUIColor)
                }
            }
            .multilineTextAlignment(.leading)
            Spacer()
            if showsChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(Colors.Content.secondary.swiftUIColor)
                    .accessibilityHidden(true)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Preview

#Preview {
    ListRowView(
        title: "hello@lapka.example и текст на 2 строки",
        systemImage: "envelope",
        subtitle: "Вопросы и предложения и текст на 2 строки"
    )
    .padding()
}
