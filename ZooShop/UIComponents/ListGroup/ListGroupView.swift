//
//  ListGroupView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 27.10.2026.
//

import SwiftUI

struct ListGroupView: View {

    // MARK: - Init Properties

    let rows: [any ListGroupContent]

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            ForEach(rows.indices, id: \.self) { index in
                if index != rows.startIndex {
                    Rectangle()
                        .fill(Colors.Borders.subtle.swiftUIColor)
                        .frame(height: 0.5)
                        .accessibilityHidden(true)
                }
                rows[index].groupRowView
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
    ListGroupView(rows: [
        ListRowView(title: "О приложении", systemImage: "info.circle"),
        ListRowView(title: "Настройки", systemImage: "gearshape"),
        ListRowView(title: "Избранное", systemImage: "heart")
    ])
    .padding()
}

#Preview("SelectionRows") {
    ListGroupView(rows: [
        SelectionRowView(title: "Короткий заголовок", isSelected: false) {},
        SelectionRowView(title: "Длинный заголовок\nна две строки", isSelected: true) {}
    ])
    .padding()
}

#Preview("Mixed rows") {
    NavigationStack {
        ListGroupView(rows: [
            ListRowView(title: "Информация", systemImage: "info.circle", showsChevron: false),
            SelectionRowView(title: "Выбранный вариант", isSelected: true, systemImage: "info.circle") {},
            Button {} label: {
                ListRowView(title: "Действие", systemImage: "heart")
            },
            NavigationLink {
                Text("Подробности")
            } label: {
                ListRowView(title: "Подробнее", systemImage: "info.circle")
            }
        ])
        .padding()
    }
}
