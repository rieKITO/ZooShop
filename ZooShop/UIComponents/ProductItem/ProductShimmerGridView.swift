import SwiftUI

struct ProductShimmerGridView: View {
    
    // MARK: - Init Properties
    
    var count = 6
    
    // MARK: - Body

    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), alignment: .top),
                GridItem(.flexible(), alignment: .top)
            ],
            spacing: 20
        ) {
            ForEach(0..<count, id: \.self) { _ in
                ProductItemShimmerView()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Colors.Backgrounds.canvas.swiftUIColor
            .ignoresSafeArea()
        
        ProductShimmerGridView(count: 2)
            .padding(16)
    }
}
