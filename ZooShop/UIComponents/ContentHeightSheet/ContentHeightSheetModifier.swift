//
//  ContentHeightSheetModifier.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 29.10.2026.
//

import SwiftUI

private struct ContentHeightSheetModifier: ViewModifier {

    // MARK: - State

    @State
    private var contentHeight: CGFloat = 0

    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .fixedSize(horizontal: false, vertical: true)
            .onGeometryChange(for: CGFloat.self) { geometry in
                geometry.size.height
            } action: { height in
                contentHeight = height
            }
            .presentationDetents([.height(max(contentHeight, 1))])
    }
}

// MARK: - View Extension

extension View {

    /// Sizes a sheet to its content, including any padding applied before this modifier.
    /// Apply inside `.sheet` to content with an intrinsic height, rather than a List or ScrollView.
    func contentHeightSheet() -> some View {
        modifier(ContentHeightSheetModifier())
    }
}
