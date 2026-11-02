import SwiftUI

struct SplashView: View {
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("Backgrounds/canvas")
                Image("splashPets")
                    .resizable()
                    .scaledToFit()
                    .frame(width: min(280, geometry.size.width * 0.72, geometry.size.height * 0.72))
                    .accessibilityHidden(true)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea()
    }
}

// MARK: - Preview

#Preview("Light Theme") {
    SplashView()
}

#Preview("Dark Theme") {
    SplashView()
        .preferredColorScheme(.dark)
}
