//
//  InfoCardView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 06.10.2026.
//

import SwiftUI

struct InfoCardView: View {
    enum Size {
        case big
        case small

        var titleFont: Font {
            switch self {
            case .big: .title
            case .small: .headline
            }
        }

        var imageWidth: CGFloat {
            switch self {
            case .big: 180
            case .small: 120
            }
        }
    }
    
    // MARK: - Init Properties
    
    let card: InfoCard
    var size: Size = .big
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                Text(card.tag.uppercased())
                    .font(.caption)
                    .fontWeight(.medium)
                Text(card.title)
                    .font(size.titleFont)
                    .fontWeight(.bold)
                Text(card.description)
                    .font(.caption)
            }
            .foregroundStyle(Colors.Content.onBanner.swiftUIColor)
            .padding(.vertical, 16)
            .padding(.leading, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

            if let image = card.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.imageWidth, alignment: .bottom)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(card.backgroundColor)
        )
    }
}

// MARK: - Preview

#Preview("Big Card") {
    InfoCardView(card: InfoCard(
        tag: "Осень с заботой",
        title: "Большая забота. Маленькая цена.",
        description: "До -20% на любимый корм для вашего питомца.",
        backgroundColor: Colors.Decorative.promoPeach.swiftUIColor,
        image: Image("dogCutout")
    ))
    .padding(.vertical, 270)
}

#Preview("Small Card") {
    InfoCardView(
        card: InfoCard(
            tag: "Осень с заботой",
            title: "Большая забота. Маленькая цена.",
            description: "До -20% на любимый корм для вашего питомца.",
            backgroundColor: Colors.Decorative.promoPeach.swiftUIColor,
            image: Image("dogCutout")
        ),
        size: .small
    )
    .padding(.vertical, 300)
}
