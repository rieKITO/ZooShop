//
//  FactCardView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 28.10.2026.
//

import SwiftUI

struct FactCardView: View {

    // MARK: - Init Properties

    let value: String
    let caption: String
    let systemImage: String

    // MARK: - Body

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(systemName: systemImage)
                .font(.title3)
                .foregroundStyle(Colors.Content.accent.swiftUIColor)
                .accessibilityHidden(true)
            Text(value)
                .font(.title.weight(.bold))
                .foregroundStyle(Colors.Content.primary.swiftUIColor)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
            Text(caption)
                .font(.caption)
                .foregroundStyle(Colors.Content.secondary.swiftUIColor)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Preview

#Preview {
    FactCardView(value: "100%", caption: "любви к питомцам", systemImage: "heart")
        .padding()
}
