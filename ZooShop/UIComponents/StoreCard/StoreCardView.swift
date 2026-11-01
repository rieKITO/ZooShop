//
//  StoreCardView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 30.10.2026.
//

import SwiftUI

struct StoreCardView: View {

    // MARK: - Init Properties

    let store: Store
    let date: Date

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(store.name)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(Colors.Content.primary.swiftUIColor)
                .accessibilityAddTraits(.isHeader)

            VStack(alignment: .leading, spacing: 8) {
                Text(store.address)
                Text(store.phoneNumber)
                Text(L10n.Stores.dailyHours(store.workingHours.formatted))
                    .padding(.top, 4)
            }
            .font(.subheadline)
            .foregroundStyle(Colors.Content.secondary.swiftUIColor)

            Rectangle()
                .fill(Colors.Borders.subtle.swiftUIColor)
                .frame(height: 1)
                .accessibilityHidden(true)

            Text(store.isOpen(at: date) ? L10n.Stores.open : L10n.Stores.closed)
                .font(.footnote)
                .foregroundStyle(
                    store.isOpen(at: date)
                    ? Colors.States.positive.swiftUIColor
                    : Colors.States.destructive.swiftUIColor
                )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Colors.Backgrounds.surface.swiftUIColor)
        )
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Preview

#Preview {
    StoreCardView(
        store:
            Store(
                id: "1",
                name: "Лапка",
                address: "Улица Пушкина, дом Калатушкина",
                phoneNumber: "+7 (000) 000-00-00",
                workingHours: DailyWorkingHours(
                    opening: .init(hour: 10),
                    closing: .init(hour: 17)
                ),
                timeZone: TimeZone(identifier: "Europe/Moscow")!
            ),
        date: .now)
}
