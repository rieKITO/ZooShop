//
//  CustomTabBarView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 06.10.2026.
//

import SwiftUI

struct CustomTabBarView<Tab: TabBarItem>: View {

    let tabs: [Tab]

    @Binding
    var selectedTab: Tab

    @Namespace
    private var animation

    @ScaledMetric(relativeTo: .title2)
    private var iconHeight: CGFloat = 28

    // MARK: - Body

    var body: some View {
        ZStack {
            BlurView(style: .systemUltraThinMaterial)
                .frame(height: 75)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            tabItems
                .padding(.horizontal)
        }
        .frame(height: 95, alignment: .bottom)
        .padding(.horizontal)
    }

}

// MARK: - Subviews

private extension CustomTabBarView {

    private var tabItems: some View {
        HStack(alignment: .top) {
            ForEach(tabs, id: \.self) { tab in
                VStack(spacing: 8) {
                    if selectedTab == tab {
                        Capsule()
                            .fill(tab.color)
                            .frame(width: 30, height: 4)
                            .matchedGeometryEffect(id: "indicator", in: animation)
                    } else {
                        Spacer().frame(height: 4)
                    }

                    Button(action: {
                        withAnimation(.spring()) {
                            selectedTab = tab
                        }
                    }) {
                        VStack(spacing: 2) {
                            Image(systemName: tab.icon)
                                .font(.title2)
                                .frame(height: iconHeight)
                                .foregroundColor(selectedTab == tab ? tab.color : .gray)

                            Text(tab.title)
                                .font(.caption)
                                .lineLimit(1)
                                .foregroundColor(selectedTab == tab ? tab.color : .gray)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

}

struct BlurView: UIViewRepresentable {

    let style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}

}

// MARK: - Preview

private enum PreviewTab: CaseIterable, TabBarItem {
    case favorites
    case profile

    var title: String {
        switch self {
        case .favorites: return "Избранное"
        case .profile: return "Профиль"
        }
    }

    var icon: String {
        switch self {
        case .favorites: return "heart.fill"
        case .profile: return "person.fill"
        }
    }

    var color: Color { .accentColor }
}

#Preview("Light Mode") {

    struct Preview: View {

        @State
        private var selectedTab: PreviewTab = .favorites

        var body: some View {
            ZStack {
                VStack {
                    Spacer()
                    CustomTabBarView(tabs: PreviewTab.allCases, selectedTab: $selectedTab)
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }

    }

    return Preview()

}

#Preview("Dark Mode") {

    struct Preview: View {

        @State
        private var selectedTab: PreviewTab = .favorites

        var body: some View {
            ZStack {
                VStack {
                    Spacer()
                    CustomTabBarView(tabs: PreviewTab.allCases, selectedTab: $selectedTab)
                }
                .ignoresSafeArea(edges: .bottom)
            }
            .preferredColorScheme(.dark)
        }

    }

    return Preview()

}
