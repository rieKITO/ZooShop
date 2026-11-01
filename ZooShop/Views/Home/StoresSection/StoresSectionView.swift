import SwiftUI

struct StoresSectionView: View {

    // MARK: - Init Properties

    let viewModel: StoresViewModel

    // MARK: - Environment

    @Environment(\.tabBarContentInset)
    private var tabBarContentInset

    // MARK: - Body

    var body: some View {
        GeometryReader { geometry in
            TimelineView(.everyMinute) { context in
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(L10n.Stores.title)
                            .font(.title.weight(.heavy))
                            .foregroundStyle(Colors.Content.primary.swiftUIColor)
                            .accessibilityAddTraits(.isHeader)
                            .padding(.vertical, 20)

                        if let errorMessage = viewModel.errorMessage, !viewModel.isLoading {
                            Spacer(minLength: 0)

                            ErrorStateView(
                                title: L10n.Stores.Error.title,
                                description: errorMessage,
                                buttonLabel: L10n.Common.retry
                            ) {
                                viewModel.loadStores()
                            }

                            Spacer(minLength: 0)
                        } else {
                            if viewModel.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                            } else if viewModel.stores.isEmpty {
                                Text(L10n.Stores.empty)
                                    .frame(maxWidth: .infinity)
                            } else {
                                LazyVStack(spacing: 24) {
                                    ForEach(viewModel.stores) { store in
                                        StoreCardView(store: store, date: context.date)
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(
                        minHeight: max(0, geometry.size.height - tabBarContentInset - 24),
                        alignment: .top
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
                .contentMargins(.bottom, tabBarContentInset, for: .scrollContent)
            }
        }
        .background(
            Colors.Backgrounds.canvas.swiftUIColor
                .ignoresSafeArea()
        )
        .task {
            viewModel.loadIfNeeded()
        }
    }

}

// MARK: - Preview

#Preview("Light Theme") {
    StoresSectionView(viewModel: StoresViewModel(repository: PreviewStoreRepository()))
}

#Preview("Dark Theme") {
    StoresSectionView(viewModel: StoresViewModel(repository: PreviewStoreRepository()))
        .preferredColorScheme(.dark)
}
