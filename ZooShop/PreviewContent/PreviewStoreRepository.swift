#if DEBUG
import Combine
import Foundation

@MainActor
struct PreviewStoreRepository: StoreRepository {

    // MARK: - Static Properties

    static let stores: [Store] = [
        makeStore(id: "pokrovka", name: "Лапка на Покровке", address: "Москва, ул. Покровка, 19", openingHour: 10, closingHour: 11),
        makeStore(id: "maroseyka", name: "Лапка на Маросейке", address: "Москва, ул. Маросейка, 8", openingHour: 9, closingHour: 22),
        makeStore(id: "tverskaya", name: "Лапка на Тверской", address: "Москва, ул. Тверская, 22", openingHour: 10, closingHour: 21)
    ]

    // MARK: - Public Methods

    func loadStores() -> AnyPublisher<[Store], Error> {
        Just(Self.stores)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // MARK: - Private Methods

    private static func makeStore(
        id: String,
        name: String,
        address: String,
        openingHour: Int,
        closingHour: Int
    ) -> Store {
        Store(
            id: id,
            name: name,
            address: address,
            phoneNumber: "+7 (000) 000-00-00",
            workingHours: DailyWorkingHours(
                opening: .init(hour: openingHour),
                closing: .init(hour: closingHour)
            ),
            timeZone: TimeZone(identifier: "Europe/Moscow")!
        )
    }
}
#endif
