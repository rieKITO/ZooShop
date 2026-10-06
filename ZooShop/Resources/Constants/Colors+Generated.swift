// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Colors {
  internal enum Backgrounds {
    internal static let accentSoft = ColorAsset(name: "Backgrounds/accentSoft")
    internal static let canvas = ColorAsset(name: "Backgrounds/canvas")
    internal static let controlTrack = ColorAsset(name: "Backgrounds/controlTrack")
    internal static let surface = ColorAsset(name: "Backgrounds/surface")
    internal static let toast = ColorAsset(name: "Backgrounds/toast")
  }
  internal enum Borders {
    internal static let decorativeRing = ColorAsset(name: "Borders/decorativeRing")
    internal static let focus = ColorAsset(name: "Borders/focus")
    internal static let selected = ColorAsset(name: "Borders/selected")
    internal static let subtle = ColorAsset(name: "Borders/subtle")
  }
  internal enum Brand {
    internal static let primary = ColorAsset(name: "Brand/primary")
    internal static let warmAccent = ColorAsset(name: "Brand/warmAccent")
  }
  internal enum Content {
    internal static let accent = ColorAsset(name: "Content/accent")
    internal static let onAccent = ColorAsset(name: "Content/onAccent")
    internal static let onBanner = ColorAsset(name: "Content/onBanner")
    internal static let onToast = ColorAsset(name: "Content/onToast")
    internal static let primary = ColorAsset(name: "Content/primary")
    internal static let secondary = ColorAsset(name: "Content/secondary")
  }
  internal enum Decorative {
    internal static let articleMist = ColorAsset(name: "Decorative/articleMist")
    internal static let articleSand = ColorAsset(name: "Decorative/articleSand")
    internal static let bannerButton = ColorAsset(name: "Decorative/bannerButton")
    internal static let categoryBird = ColorAsset(name: "Decorative/categoryBird")
    internal static let categoryCat = ColorAsset(name: "Decorative/categoryCat")
    internal static let categoryDog = ColorAsset(name: "Decorative/categoryDog")
    internal static let categorySmallPet = ColorAsset(name: "Decorative/categorySmallPet")
    internal static let promoPeach = ColorAsset(name: "Decorative/promoPeach")
    internal static let promoSage = ColorAsset(name: "Decorative/promoSage")
    internal static let sparkle = ColorAsset(name: "Decorative/sparkle")
  }
  internal enum Effects {
    internal static let controlShadow = ColorAsset(name: "Effects/controlShadow")
    internal static let modalScrim = ColorAsset(name: "Effects/modalScrim")
    internal static let pinShadow = ColorAsset(name: "Effects/pinShadow")
    internal static let productShadow = ColorAsset(name: "Effects/productShadow")
    internal static let softShadow = ColorAsset(name: "Effects/softShadow")
    internal static let switchShadow = ColorAsset(name: "Effects/switchShadow")
  }
  internal enum States {
    internal static let destructive = ColorAsset(name: "States/destructive")
    internal static let positive = ColorAsset(name: "States/positive")
    internal static let rating = ColorAsset(name: "States/rating")
    internal static let saleBackground = ColorAsset(name: "States/saleBackground")
    internal static let saleForeground = ColorAsset(name: "States/saleForeground")
    internal static let skeletonBase = ColorAsset(name: "States/skeletonBase")
    internal static let skeletonHighlight = ColorAsset(name: "States/skeletonHighlight")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
