import SwiftUI

/// The presentation data required by `InfoCardView`.
struct InfoCard {
    var tag: String
    var title: String
    var description: String
    var backgroundColor: Color
    var image: Image? = nil
}
