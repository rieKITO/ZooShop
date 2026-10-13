//
//  ErrorStateView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 13.10.2026.
//

import SwiftUI

struct ErrorStateView: View {
    
    // MARK: - Init Properties
    
    let title: String
    let description: String
    let buttonLabel: String
    let action: () -> Void
    
    // MARK: - Body

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundStyle(Colors.Content.primary.swiftUIColor)
            Text(description)
                .font(.subheadline)
                .foregroundStyle(Colors.Content.secondary.swiftUIColor)
            Button(action: action) {
                Text(buttonLabel)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Colors.Content.onAccent.swiftUIColor)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 14))
            .tint(Colors.Brand.primary.swiftUIColor)
            .controlSize(.large)
            .padding(.top, 8)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Colors.Backgrounds.canvas.swiftUIColor.ignoresSafeArea()
        ErrorStateView(
            title: "Невероятно длинное название ошибки на две строки",
            description: "Не удалось подключиться к серверу. Попробуйте ещё раз.",
            buttonLabel: L10n.Common.retry,
            action: {}
        )
        .padding(.horizontal, 16)
    }
}
