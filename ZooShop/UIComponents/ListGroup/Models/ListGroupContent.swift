import SwiftUI

/// A row supported by a list group.
protocol ListGroupContent: View {
    var groupRowView: AnyView { get }
}

extension ListGroupContent {
    var groupRowView: AnyView { AnyView(self) }
}

extension Button: ListGroupContent where Label: ListGroupContent {}
extension NavigationLink: ListGroupContent where Label: ListGroupContent {}
