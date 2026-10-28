//
//  FactGroupView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 28.10.2026.
//

import SwiftUI

struct FactGroupView: View {

    // MARK: - Init Properties

    let facts: [FactCardView]

    // MARK: - Environment

    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    // MARK: - Body

    var body: some View {
        let layout = dynamicTypeSize.isAccessibilitySize
            ? AnyLayout(VStackLayout(spacing: 20))
            : AnyLayout(HStackLayout(alignment: .top, spacing: 12))

        layout {
            ForEach(facts.indices, id: \.self) { index in
                if index != facts.startIndex {
                    separator
                }
                facts[index]
            }
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Colors.Backgrounds.surface.swiftUIColor)
        )
    }
}

// MARK: - Subviews

private extension FactGroupView {

    var separator: some View {
        Rectangle()
            .fill(Colors.Borders.subtle.swiftUIColor)
            .frame(
                width: dynamicTypeSize.isAccessibilitySize ? nil : 0.5,
                height: dynamicTypeSize.isAccessibilitySize ? 0.5 : 80
            )
            .accessibilityHidden(true)
    }
}

// MARK: - Preview

#Preview("Three facts") {
    FactGroupView(facts: [
        FactCardView(value: "12", caption: "лет заботы", systemImage: "leaf"),
        FactCardView(value: "3", caption: "магазина рядом", systemImage: "storefront"),
        FactCardView(value: "100%", caption: "любви к питомцам", systemImage: "heart")
    ])
    .padding()
}

#Preview("Single fact") {
    FactGroupView(facts: [
        FactCardView(value: "12", caption: "лет заботы", systemImage: "leaf")
    ])
    .padding()
}
