//
//  ZooShopApp.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 04.10.2026.
//

import SwiftUI

@main
struct ZooShopApp: App {
    
    // MARK: - State
    
    @State
    private var viewModel = AppDI.makeMainSectionViewModel()

    @State
    private var appThemeManager = AppThemeManager()

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(viewModel)
                .environment(appThemeManager)
                .preferredColorScheme(appThemeManager.colorScheme)
        }
    }
}
