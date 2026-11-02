import SwiftUI

struct StoreCardShimmerView: View {
    @ScaledMetric(relativeTo: .subheadline) private var contentHeight = 102.0

    var body: some View {
        // Text rows plus the card's padding, spacing and divider.
        ShimmerView(cornerRadius: 24)
            .frame(height: contentHeight + 117)
    }
}

#Preview {
    StoreCardShimmerView()
        .padding(16)
}
