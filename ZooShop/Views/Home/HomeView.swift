//
//  HomeView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 04.10.2026.
//

import SwiftUI

struct HomeView: View {

    @State
    private var selectedTab: HomeTab = .main

    var body: some View {
        ZStack {
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()
            tabContent
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            CustomTabBarView(tabs: HomeTab.allCases, selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }

}

// MARK: - Subviews

private extension HomeView {
    
    @ViewBuilder
    var tabContent: some View {
        switch selectedTab {
        case .main:
            MainSectionView()
        case .catalog, .shops, .more:
            Text(selectedTab.title)
        }
    }
    
}

// MARK: - Preview

#Preview("Light Mode") {
    HomeView()
}

#Preview("Dark Mode") {
    HomeView()
        .preferredColorScheme(.dark)
}
