//
//  MainSectionView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 06.10.2026.
//

import SwiftUI

struct MainSectionView: View {
    var body: some View {
        ZStack {
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    title
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            .clipped()
        }
    }
}

// MARK: - Subviews

private extension MainSectionView {
    
    private var title: some View {
        HStack(spacing: 0) {
            Image(systemName: "pawprint.fill")
                .font(.title2)
                .frame(height: 70)
                .foregroundColor(Colors.Brand.warmAccent.swiftUIColor)
            Text(L10n.Main.title)
                .foregroundStyle(Colors.Content.primary.swiftUIColor)
            Text(".")
                .foregroundStyle(Colors.Brand.warmAccent.swiftUIColor)
        }
        .font(.title)
        .fontWeight(.heavy)
    }
    
}

// MARK: - Preview

#Preview {
    MainSectionView()
}
