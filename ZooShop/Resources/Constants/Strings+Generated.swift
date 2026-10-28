// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum AboutStore {
    /// Помогаем заботиться о домашних любимцах: выбираем товары, делимся полезными советами и встречаем вас в наших магазинах.
    internal static let description = L10n.tr("Localizable", "AboutStore.description", fallback: "Помогаем заботиться о домашних любимцах: выбираем товары, делимся полезными советами и встречаем вас в наших магазинах.")
    /// «Лапка» — вымышленный магазин, созданный для демонстрационного проекта. Название, контакты и сведения о магазине приведены в качестве примера. Любые совпадения с реальными организациями, брендами или лицами случайны. Проект не связан с такими организациями и не является их официальным приложением.
    internal static let disclaimer = L10n.tr("Localizable", "AboutStore.disclaimer", fallback: "«Лапка» — вымышленный магазин, созданный для демонстрационного проекта. Название, контакты и сведения о магазине приведены в качестве примера. Любые совпадения с реальными организациями, брендами или лицами случайны. Проект не связан с такими организациями и не является их официальным приложением.")
    /// Место, где знают:
    /// питомец — часть семьи.
    internal static let tagline = L10n.tr("Localizable", "AboutStore.tagline", fallback: "Место, где знают:\nпитомец — часть семьи.")
    /// О магазине
    internal static let title = L10n.tr("Localizable", "AboutStore.title", fallback: "О магазине")
    internal enum Contacts {
      /// Адреса магазинов
      internal static let addresses = L10n.tr("Localizable", "AboutStore.contacts.addresses", fallback: "Адреса магазинов")
      /// hello@lapka.example
      internal static let email = L10n.tr("Localizable", "AboutStore.contacts.email", fallback: "hello@lapka.example")
      /// Вопросы и предложения
      internal static let emailSubtitle = L10n.tr("Localizable", "AboutStore.contacts.emailSubtitle", fallback: "Вопросы и предложения")
      /// Ежедневно, 10:00–21:00
      internal static let hours = L10n.tr("Localizable", "AboutStore.contacts.hours", fallback: "Ежедневно, 10:00–21:00")
      /// +7 (495) 000-00-00
      internal static let phone = L10n.tr("Localizable", "AboutStore.contacts.phone", fallback: "+7 (495) 000-00-00")
      /// Свяжитесь с нами
      internal static let title = L10n.tr("Localizable", "AboutStore.contacts.title", fallback: "Свяжитесь с нами")
    }
    internal enum Facts {
      internal enum Love {
        /// любви к питомцам
        internal static let caption = L10n.tr("Localizable", "AboutStore.facts.love.caption", fallback: "любви к питомцам")
        /// 100%%
        internal static let value = L10n.tr("Localizable", "AboutStore.facts.love.value", fallback: "100%%")
      }
      internal enum Shops {
        /// магазина рядом
        internal static let caption = L10n.tr("Localizable", "AboutStore.facts.shops.caption", fallback: "магазина рядом")
        /// 3
        internal static let value = L10n.tr("Localizable", "AboutStore.facts.shops.value", fallback: "3")
      }
      internal enum Years {
        /// лет заботы
        internal static let caption = L10n.tr("Localizable", "AboutStore.facts.years.caption", fallback: "лет заботы")
        /// 12
        internal static let value = L10n.tr("Localizable", "AboutStore.facts.years.value", fallback: "12")
      }
    }
  }
  internal enum Catalog {
    /// В каталоге пока нет товаров
    internal static let empty = L10n.tr("Localizable", "Catalog.empty", fallback: "В каталоге пока нет товаров")
    internal enum Error {
      /// Не удалось загрузить товары: HTTP %d.
      internal static func httpStatus(_ p1: Int) -> String {
        return L10n.tr("Localizable", "Catalog.error.httpStatus", p1, fallback: "Не удалось загрузить товары: HTTP %d.")
      }
      /// ID товаров должны быть непустыми и уникальными.
      internal static let invalidIdentifiers = L10n.tr("Localizable", "Catalog.error.invalidIdentifiers", fallback: "ID товаров должны быть непустыми и уникальными.")
      /// В каталоге неверный рейтинг или адрес изображения.
      internal static let invalidProductData = L10n.tr("Localizable", "Catalog.error.invalidProductData", fallback: "В каталоге неверный рейтинг или адрес изображения.")
      /// Сервер вернул некорректный ответ.
      internal static let invalidResponse = L10n.tr("Localizable", "Catalog.error.invalidResponse", fallback: "Сервер вернул некорректный ответ.")
      /// Не удалось загрузить товары
      internal static let title = L10n.tr("Localizable", "Catalog.error.title", fallback: "Не удалось загрузить товары")
    }
  }
  internal enum Common {
    /// Все
    internal static let all = L10n.tr("Localizable", "Common.all", fallback: "Все")
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
    /// Любимые товары
    internal static let title = L10n.tr("Localizable", "Favorites.title", fallback: "Любимые товары")
    internal enum Error {
      /// Модель Core Data не найдена в приложении.
      internal static let missingModel = L10n.tr("Localizable", "Favorites.error.missingModel", fallback: "Модель Core Data не найдена в приложении.")
    }
  }
  internal enum Main {
    /// Localizable.strings
    ///   ZooShop
    /// 
    ///   Created by Aleksandr Potemkin on 04.10.2026.
    internal static let title = L10n.tr("Localizable", "Main.title", fallback: "лапка")
  }
  internal enum More {
    /// О магазине / Контакты
    internal static let about = L10n.tr("Localizable", "More.about", fallback: "О магазине / Контакты")
    /// Лапка · с заботой о каждом питомце
    internal static let footer = L10n.tr("Localizable", "More.footer", fallback: "Лапка · с заботой о каждом питомце")
    /// Настройки
    internal static let settings = L10n.tr("Localizable", "More.settings", fallback: "Настройки")
    /// Ещё немного заботы
    internal static let title = L10n.tr("Localizable", "More.title", fallback: "Ещё немного заботы")
    internal enum Card {
      /// Мы рядом каждый день
      internal static let description = L10n.tr("Localizable", "More.card.description", fallback: "Мы рядом каждый день")
      /// Вместе с Лапкой
      internal static let tag = L10n.tr("Localizable", "More.card.tag", fallback: "Вместе с Лапкой")
      /// Счастливый питомец.
      /// Счастливы вы.
      internal static let title = L10n.tr("Localizable", "More.card.title", fallback: "Счастливый питомец.\nСчастливы вы.")
    }
  }
  internal enum PetCategories {
    /// Подберём питание для каждого питомца
    internal static let note = L10n.tr("Localizable", "PetCategories.note", fallback: "Подберём питание для каждого питомца")
    /// Забота начинается с правильного выбора
    internal static let subtitle = L10n.tr("Localizable", "PetCategories.subtitle", fallback: "Забота начинается с правильного выбора")
    /// Для вашего питомца
    internal static let title = L10n.tr("Localizable", "PetCategories.title", fallback: "Для вашего питомца")
    internal enum Bird {
      /// Корма и зерновые смеси для птиц
      internal static let subtitle = L10n.tr("Localizable", "PetCategories.bird.subtitle", fallback: "Корма и зерновые смеси для птиц")
      /// Птицы
      internal static let title = L10n.tr("Localizable", "PetCategories.bird.title", fallback: "Птицы")
    }
    internal enum Cat {
      /// Питание для счастливого мурчания
      internal static let subtitle = L10n.tr("Localizable", "PetCategories.cat.subtitle", fallback: "Питание для счастливого мурчания")
      /// Кошки
      internal static let title = L10n.tr("Localizable", "PetCategories.cat.title", fallback: "Кошки")
    }
    internal enum Dog {
      /// Сухие и влажные корма для собак
      internal static let subtitle = L10n.tr("Localizable", "PetCategories.dog.subtitle", fallback: "Сухие и влажные корма для собак")
      /// Собаки
      internal static let title = L10n.tr("Localizable", "PetCategories.dog.title", fallback: "Собаки")
    }
    internal enum SmallPet {
      /// Все для наших маленьких друзей
      internal static let subtitle = L10n.tr("Localizable", "PetCategories.smallPet.subtitle", fallback: "Все для наших маленьких друзей")
      /// Грызуны
      internal static let title = L10n.tr("Localizable", "PetCategories.smallPet.title", fallback: "Грызуны")
    }
  }
  internal enum Product {
    /// Рейтинг %.1f из 5
    internal static func rating(_ p1: Float) -> String {
      return L10n.tr("Localizable", "Product.rating", p1, fallback: "Рейтинг %.1f из 5")
    }
    internal enum Details {
      /// О товаре
      internal static let about = L10n.tr("Localizable", "Product.details.about", fallback: "О товаре")
      /// Вид животного
      internal static let animalType = L10n.tr("Localizable", "Product.details.animalType", fallback: "Вид животного")
      /// Бренд
      internal static let brand = L10n.tr("Localizable", "Product.details.brand", fallback: "Бренд")
      /// Вес упаковки
      internal static let packageWeight = L10n.tr("Localizable", "Product.details.packageWeight", fallback: "Вес упаковки")
      /// Цена справочная. Актуальную стоимость и наличие уточняйте в магазине.
      internal static let priceNote = L10n.tr("Localizable", "Product.details.priceNote", fallback: "Цена справочная. Актуальную стоимость и наличие уточняйте в магазине.")
      /// В список покупок
      internal static let shoppingList = L10n.tr("Localizable", "Product.details.shoppingList", fallback: "В список покупок")
      /// Вкус
      internal static let taste = L10n.tr("Localizable", "Product.details.taste", fallback: "Вкус")
      /// Карточка товара
      internal static let title = L10n.tr("Localizable", "Product.details.title", fallback: "Карточка товара")
      /// %@ кг
      internal static func weight(_ p1: Any) -> String {
        return L10n.tr("Localizable", "Product.details.weight", String(describing: p1), fallback: "%@ кг")
      }
      /// Где купить
      internal static let whereToBuy = L10n.tr("Localizable", "Product.details.whereToBuy", fallback: "Где купить")
    }
    internal enum Image {
      /// Повторить загрузку
      internal static let retry = L10n.tr("Localizable", "Product.image.retry", fallback: "Повторить загрузку")
    }
  }
  internal enum Settings {
    internal enum Appearance {
      /// Тёмная
      internal static let dark = L10n.tr("Localizable", "Settings.appearance.dark", fallback: "Тёмная")
      /// Светлая
      internal static let light = L10n.tr("Localizable", "Settings.appearance.light", fallback: "Светлая")
      /// Как на устройстве
      internal static let system = L10n.tr("Localizable", "Settings.appearance.system", fallback: "Как на устройстве")
      /// Оформление
      internal static let title = L10n.tr("Localizable", "Settings.appearance.title", fallback: "Оформление")
    }
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
