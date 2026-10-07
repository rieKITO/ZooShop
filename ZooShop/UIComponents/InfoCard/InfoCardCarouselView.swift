import SwiftUI

struct InfoCardCarouselView: View {
    
    // MARK: - Init Properties
    
    let cards: [InfoCard]
    var size: InfoCardView.Size = .big
    
    // MARK: - State

    @State
    private var selectedPage = 0
    
    // MARK: - Private Properties

    private let pageSpacing: CGFloat = 16
    
    // MARK: - Body

    var body: some View {
        if !cards.isEmpty {
            VStack(spacing: 12) {
                ZStack {
                    ForEach(cards.indices, id: \.self) { index in
                        cardView(for: cards[index])
                            .padding(.horizontal, pageSpacing / 2)
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .hidden()
                .overlay {
                    TabView(selection: $selectedPage) {
                        ForEach(cards.indices, id: \.self) { index in
                            cardView(for: cards[index])
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                .padding(.horizontal, pageSpacing / 2)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                .padding(.horizontal, -pageSpacing / 2)

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

    func cardView(for card: InfoCard) -> some View {
        InfoCardView(card: card, size: size)
    }
    
}
