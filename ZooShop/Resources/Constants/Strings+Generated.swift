// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Common {
    /// ОК
    internal static let ok = L10n.tr("Localizable", "Common.ok", fallback: "ОК")
    /// Повторить
    internal static let retry = L10n.tr("Localizable", "Common.retry", fallback: "Повторить")
    internal enum Error {
      /// Что-то пошло не так
      internal static let title = L10n.tr("Localizable", "Common.error.title", fallback: "Что-то пошло не так")
    }
  }
  internal enum Favorites {
    /// Добавить в избранное
    internal static let add = L10n.tr("Localizable", "Favorites.add", fallback: "Добавить в избранное")
    /// Пока нет избранных товаров. Добавьте их, нажав на сердечко в каталоге.
    internal static let empty = L10n.tr("Localizable", "Favorites.empty", fallback: "Пока нет избранных товаров. Добавьте их, нажав на сердечко в каталоге.")
    /// Убрать из избранного
    internal static let remove = L10n.tr("Localizable", "Favorites.remove", fallback: "Убрать из избранного")
    /// Избранные товары
    internal static let title = L10n.tr("Localizable", "Favorites.title", fallback: "Избранные товары")
    internal enum Error {
      /// Модель Core Data не найдена в приложении.
      internal static let missingModel = L10n.tr("Localizable", "Favorites.error.missingModel", fallback: "Модель Core Data не найдена в приложении.")
    }
  internal enum Main {
    /// Localizable.strings
    ///   ZooShop
    /// 
    ///   Created by Aleksandr Potemkin on 04.10.2026.
    internal static let title = L10n.tr("Localizable", "Main.title", fallback: "лапка")
  }
  internal enum TabBar {
    internal enum Category {
      /// Каталог
      internal static let catalog = L10n.tr("Localizable", "TabBar.category.catalog", fallback: "Каталог")
      /// Главная
      internal static let main = L10n.tr("Localizable", "TabBar.category.main", fallback: "Главная")
      /// Ещё
      internal static let more = L10n.tr("Localizable", "TabBar.category.more", fallback: "Ещё")
      /// Магазины
      internal static let shops = L10n.tr("Localizable", "TabBar.category.shops", fallback: "Магазины")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

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
