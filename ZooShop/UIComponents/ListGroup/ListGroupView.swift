//
//  ListGroupView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 27.10.2026.
//

import SwiftUI

struct ListGroupView<Content: View>: View {

    // MARK: - Init Properties

    @ViewBuilder
    let content: Content

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            Group(subviews: content) { subviews in
                ForEach(subviews) { subview in
                    if subview.id != subviews.first?.id {
                        Rectangle()
                            .fill(Colors.Borders.subtle.swiftUIColor)
                            .frame(height: 0.5)
                            .accessibilityHidden(true)
                    }
                    subview
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Colors.Backgrounds.surface.swiftUIColor)
        )
    }
}

// MARK: - Preview

#Preview("ListRows") {
    ListGroupView {
        ListRowView(title: "О приложении", systemImage: "info.circle")
        ListRowView(title: "Настройки", systemImage: "gearshape")
        ListRowView(title: "Избранное", systemImage: "heart")
    }
    .padding()
}

#Preview("SelectionRows") {
    ListGroupView {
        SelectionRowView(title: "Короткий заголовок", isSelected: false) {}
        SelectionRowView(
            title: "Длинный заголовок\nна две строки",
            isSelected: true
        ) {}
    }
    .padding()
}

