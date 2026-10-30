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
    var systemImage: String? = nil
    var showsChevron: Bool = true
    var subtitle: String? = nil
    var value: String? = nil
    
    // MARK: - Body

    var body: some View {
        HStack(spacing: 16) {
            if let systemImage {
                Image(systemName: systemImage)
                    .font(.title2)
                    .foregroundStyle(Colors.Content.accent.swiftUIColor)
                    .accessibilityHidden(true)
            }
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
            if let value {
                Text(value)
                    .font(.caption)
                    .foregroundStyle(Colors.Content.secondary.swiftUIColor)
                    .multilineTextAlignment(.trailing)
            }
            if showsChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(Colors.Content.secondary.swiftUIColor)
                    .accessibilityHidden(true)
            }
        }
        .padding(20)
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

#Preview("With value") {
    ListRowView(title: "Версия", showsChevron: false, value: "1.0")
        .padding()
}

#Preview("Without image") {
    ListRowView(title: "Подробнее")
        .padding()
}
