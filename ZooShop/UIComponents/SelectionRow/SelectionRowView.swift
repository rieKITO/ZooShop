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
    let action: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 16) {
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

#Preview() {
    SelectionRowView(
        title: "Длинный заголовок\nна две строки",
        isSelected: true
    ) {}
    .padding()
}
