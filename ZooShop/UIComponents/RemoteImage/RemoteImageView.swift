//
//  RemoteImageView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 22.10.2026.
//

import SwiftUI

struct RemoteImageView<Content: View>: View {

    // MARK: - Init Properties

    let url: URL
    
    @ViewBuilder
    let content: (AsyncImagePhase, @escaping () -> Void) -> Content

    // MARK: - Environment

    @Environment(\.imageLoader)
    private var imageLoader

    // MARK: - State

    @State
    private var viewModel = RemoteImageViewModel()

    // MARK: - Body

    var body: some View {
        content(viewModel.phase(for: url), retry)
            .onAppear {
                viewModel.load(url, using: imageLoader)
            }
            .onChange(of: url) { _, newURL in
                viewModel.load(newURL, using: imageLoader)
            }
            .onDisappear {
                viewModel.cancel()
            }
    }

}

// MARK: - Private Methods

private extension RemoteImageView {
    
    func retry() {
        viewModel.load(url, using: imageLoader)
    }
    
}
