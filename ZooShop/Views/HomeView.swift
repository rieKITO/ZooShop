//
//  HomeView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 04.10.2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
