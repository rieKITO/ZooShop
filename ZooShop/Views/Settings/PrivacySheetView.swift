//
//  PrivacySheetView.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 28.10.2026.
//

import SwiftUI

struct PrivacySheetView: View {

    // MARK: - Environment

    @Environment(\.dismiss)
    private var dismiss

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            header
            message
            confirmButton
        }
        .padding(.horizontal, 24)
        .padding(.top, 32)
        .padding(.bottom, 16)
        .contentHeightSheet()
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(32)
        .presentationBackground(Colors.Backgrounds.canvas.swiftUIColor)
    }
}

// MARK: - Subviews

private extension PrivacySheetView {

    var header: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(L10n.Settings.Privacy.title)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundStyle(Colors.Content.primary.swiftUIColor)
                .frame(alignment: .leading)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            closeButton
        }
    }

    var message: some View {
        Text(L10n.Settings.Privacy.message)
            .font(.body)
            .foregroundStyle(Colors.Content.secondary.swiftUIColor)
            .lineSpacing(6)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 18))
                .foregroundStyle(Colors.Content.primary.swiftUIColor)
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(Colors.Backgrounds.surface.swiftUIColor)
                )
        }
        .accessibilityLabel(L10n.Common.close)
    }

    var confirmButton: some View {
        Button {
            dismiss()
        } label: {
            Text(L10n.Settings.Privacy.confirm)
                .font(.body)
                .fontWeight(.bold)
                .foregroundStyle(Colors.Content.onAccent.swiftUIColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Colors.Brand.primary.swiftUIColor)
                )
        }
    }
}

// MARK: - Preview

#Preview("Light Theme") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            PrivacySheetView()
        }
}

#Preview("Dark Theme") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            PrivacySheetView()
        }
        .preferredColorScheme(.dark)
}
