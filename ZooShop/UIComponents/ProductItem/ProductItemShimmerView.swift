import SwiftUI

struct ProductItemShimmerView: View {
    
    // MARK: - Private Properties
    
    @ScaledMetric(relativeTo: .callout)
    private var priceHeight = 20.0
    
    @ScaledMetric(relativeTo: .caption)
    private var textHeight = 14.0
    
    @ScaledMetric(relativeTo: .caption2)
    private var detailsHeight = 13.0
    
    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ShimmerView(cornerRadius: 24)
                .aspectRatio(1, contentMode: .fit)
            stripe(width: 0.55, height: priceHeight)
                .padding(.top, 8)
            stripe(width: 0.85, height: textHeight)
            stripe(width: 1, height: textHeight)
            stripe(width: 0.65, height: detailsHeight)
        }
        .accessibilityHidden(true)
    }
    
}

// MARK: - Private Methods

private extension ProductItemShimmerView {
    
     func stripe(width: CGFloat, height: CGFloat) -> some View {
        GeometryReader { geometry in
            ShimmerView(cornerRadius: 4)
                .frame(width: geometry.size.width * width, height: height - 4)
                .padding(.vertical, 2)
        }
        .frame(height: height)
    }
    
}

// MARK: - Preview

#Preview {
    ZStack {
        Colors.Backgrounds.canvas.swiftUIColor
            .ignoresSafeArea()
        
        ProductItemShimmerView()
            .padding()
    }
}
