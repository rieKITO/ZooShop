//
//  ImageInRoundedRectangleView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 14.10.2026.
//

import SwiftUI

struct ImageInRoundedRectangleView: View {
    
    // MARK: - Init Properties
    
    let imageName: String
    let rectangleBackgroundColor: Color
    var imageSize: CGFloat = 80.0
    
    // MARK: - Body
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: imageSize, height: imageSize, alignment: .center)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(rectangleBackgroundColor)
            )
    }
}

// MARK: - Preview

#Preview {
    ImageInRoundedRectangleView(
        imageName: "animalDogEmoji",
        rectangleBackgroundColor: Colors.Decorative.articleMist.swiftUIColor,
        imageSize: 80
    )
}
