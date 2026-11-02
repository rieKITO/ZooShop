import SwiftUI

@main
struct ZooShopApp: App {
    
    // MARK: - State
    
    @State
    private var viewModel = AppDI.makeMainSectionViewModel()

    @State
    private var appThemeManager = AppThemeManager()

    @State
    private var showsSplash = true

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeView()
                if showsSplash {
                    SplashView()
                        .zIndex(1)
                }
            }
                .environment(viewModel)
                .environment(appThemeManager)
                .preferredColorScheme(appThemeManager.colorScheme)
                .task {
                    do {
                        try await Task.sleep(for: .milliseconds(800))
                    } catch {
                        return
                    }
                    showsSplash = false
                }
        }
    }
}
