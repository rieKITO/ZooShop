//
//  AnimalRowView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 14.10.2026.
//

import SwiftUI

struct AnimalRowView: View {
    
    // MARK: - Init Properties
    
    let imageName: String
    let title: String
    let subtitle: String

    var animalImageSize: CGFloat = 48
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 20) {
            ImageInRoundedRectangleView(
                imageName: imageName,
                rectangleBackgroundColor: Colors.Backgrounds.accentSoft.swiftUIColor,
                imageSize: animalImageSize
            )
            titleAndSubtitle
                .frame(maxWidth: .infinity, alignment: .leading)
            chevron
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Colors.Backgrounds.surface.swiftUIColor)
        )
    }

}

// MARK: - Subviews

private extension AnimalRowView {
    
    var titleAndSubtitle: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Colors.Content.primary.swiftUIColor)
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(Colors.Content.secondary.swiftUIColor)
        }
    }
    
    var chevron: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(Colors.Content.secondary.swiftUIColor)
    }
    
}

// MARK: - Preview

#Preview("Light Theme") {
    ZStack {
        Colors.Backgrounds.canvas.swiftUIColor
            .ignoresSafeArea()
        
        AnimalRowView(
            imageName: "animalDogEmoji",
            title: L10n.PetCategories.Dog.title,
            subtitle: L10n.PetCategories.Dog.subtitle
        )
        .padding(.horizontal, 16)
    }
}

#Preview("Dark Theme") {
    ZStack {
        Colors.Backgrounds.canvas.swiftUIColor
            .ignoresSafeArea()
        
        AnimalRowView(
            imageName: "animalDogEmoji",
            title: L10n.PetCategories.Dog.title,
            subtitle: L10n.PetCategories.Dog.subtitle
        )
        .padding(.horizontal, 16)
    }
    .preferredColorScheme(.dark)
}
