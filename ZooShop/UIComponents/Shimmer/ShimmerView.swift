import SwiftUI

/// Shared animated placeholder used by component skeletons.
struct ShimmerView: View {
    
    // MARK: - Init Properties
    
    var cornerRadius: CGFloat = 6
    
    // MARK: - Environment

    @Environment(\.accessibilityReduceMotion)
    private var reduceMotion
    
    // MARK: - State
    
    @State
    private var isAnimating = false
    
    // MARK: - Body

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(Colors.Backgrounds.surface.swiftUIColor)
            .overlay {
                GeometryReader { geometry in
                    LinearGradient(
                        colors: [.clear, Colors.Content.secondary.swiftUIColor.opacity(0.16), .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .offset(x: isAnimating ? geometry.size.width : -geometry.size.width)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .onAppear {
                isAnimating = true
            }
            .animation(
                reduceMotion ? nil : .linear(duration: 1.2).repeatForever(autoreverses: false),
                value: isAnimating
            )
            .accessibilityHidden(true)
            .allowsHitTesting(false)
    }
}
