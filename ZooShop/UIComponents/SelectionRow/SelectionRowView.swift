//
//  SelectionRowView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 27.10.2026.
//

import SwiftUI

struct SelectionRowView: View {

    // MARK: - Init Properties

    let title: String
    let isSelected: Bool
    var systemImage: String? = nil
    let action: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 16) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.title2)
                        .foregroundStyle(Colors.Content.accent.swiftUIColor)
                        .accessibilityHidden(true)
                }
                Text(title)
                    .font(.body)
                    .foregroundStyle(Colors.Content.primary.swiftUIColor)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .font(.title3)
                    .foregroundStyle(
                        isSelected
                            ? Colors.Content.accent.swiftUIColor
                            : Colors.Content.secondary.swiftUIColor
                    )
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .frame(minHeight: 70)
        }
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

// MARK: - Preview

#Preview("Without image") {
    SelectionRowView(
        title: "Длинный заголовок\nна две строки",
        isSelected: true
    ) {}
    .padding()
}

#Preview("With image") {
    SelectionRowView(
        title: "Светлая тема",
        isSelected: true,
        systemImage: "sun.max"
    ) {}
    .padding()
}
