//
//  InfoCardCarouselView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 06.10.2026.
//

import SwiftUI

struct InfoCardCarouselView: View {
    
    // MARK: - Init Properties
    
    let cards: [InfoCard]
    var size: InfoCardView.Size = .big
    
    // MARK: - State

    @State
    private var selectedPage: Int? = 0
    
    // MARK: - Body

    var body: some View {
        if !cards.isEmpty {
            VStack(spacing: 12) {
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(cards.indices, id: \.self) { index in
                            InfoCardView(card: cards[index], size: size)
                                .containerRelativeFrame(.horizontal)
                                .id(index)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned(limitBehavior: .alwaysByOne))
                .scrollPosition(id: $selectedPage, anchor: .center)

                pageIndicator
            }
        }
    }

}

// MARK: - Subviews

private extension InfoCardCarouselView {
    
    var pageIndicator: some View {
        HStack(spacing: 0) {
            ForEach(cards.indices, id: \.self) { index in
                Button {
                    withAnimation {
                        selectedPage = index
                    }
                } label: {
                    Circle()
                        .fill(index == selectedPage
                              ? Colors.Content.accent.swiftUIColor
                              : Colors.Content.secondary.swiftUIColor.opacity(0.3))
                        .frame(width: 8, height: 8)
                        .padding(8)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(index == selectedPage ? .isSelected : [])
            }
        }
    }
    
}
