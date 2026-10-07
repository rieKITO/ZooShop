//
//  MainSectionView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 06.10.2026.
//

import SwiftUI

struct MainSectionView: View {
    private let cards: [InfoCard] = [
        InfoCard(
            tag: "Осень с заботой",
            title: "Большая забота. Маленькая цена.",
            description: "До -20% на любимый корм для вашего питомца.",
            backgroundColor: Colors.Decorative.promoPeach.swiftUIColor,
            image: Image("dogCutout")
        ),
        InfoCard(
            tag: "Для уютного дома",
            title: "Уют для любимого питомца.",
            description: "Лежанки, игрушки и всё для счастливых дней дома.",
            backgroundColor: Colors.Decorative.promoSage.swiftUIColor,
            image: Image("hamsterCutout")
        ),
        InfoCard(
            tag: "Каждый день вместе",
            title: "Время для прогулки!",
            description: "Подберите аксессуары для прогулок с вашим другом.",
            backgroundColor: Colors.Decorative.articleMist.swiftUIColor,
            image: Image("catCutout")
        )
    ]

    var body: some View {
        ZStack {
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    title
                        .frame(maxWidth: .infinity, alignment: .leading)
                    infoCards
                        .padding(.top, 8)
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            .clipped()
        }
    }
}

// MARK: - Subviews

private extension MainSectionView {
    
    var title: some View {
        HStack(spacing: 0) {
            Image(systemName: "pawprint.fill")
                .font(.title2)
                .frame(height: 70)
                .foregroundColor(Colors.Brand.warmAccent.swiftUIColor)
            Text(L10n.Main.title)
                .foregroundStyle(Colors.Content.primary.swiftUIColor)
            Text(".")
                .foregroundStyle(Colors.Brand.warmAccent.swiftUIColor)
        }
        .font(.title)
        .fontWeight(.heavy)
    }
    
    var infoCards: some View {
        InfoCardCarouselView(cards: cards, size: .big)
    }
    
}

// MARK: - Preview

#Preview {
    MainSectionView()
}
