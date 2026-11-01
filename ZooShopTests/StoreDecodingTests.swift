import Foundation
import XCTest
@testable import ZooShop

final class StoreDecodingTests: XCTestCase {
    func testDecodesStoreAndOvernightSchedule() throws {
        let store = try decode()
        XCTAssertEqual(store.id, "store")
        XCTAssertEqual(store.timeZone.identifier, "Europe/Moscow")
        XCTAssertEqual(store.workingHours.formatted, "22:00–06:30")
        XCTAssertTrue(store.workingHours.contains(minutesSinceMidnight: 23 * 60))
        XCTAssertTrue(store.workingHours.contains(minutesSinceMidnight: 6 * 60))
        XCTAssertFalse(store.workingHours.contains(minutesSinceMidnight: 6 * 60 + 30))
    }

    func testRejectsInvalidTimeComponents() {
        for (hour, minute) in [(-1, 0), (24, 0), (12, -1), (12, 60)] {
            XCTAssertThrowsError(try decode(hour: hour, minute: minute)) { error in
                guard case DecodingError.dataCorrupted = error else {
                    return XCTFail("Expected dataCorrupted, received \(error)")
                }
            }
        }
    }

    func testRejectsUnknownTimeZoneAndBlankFields() {
        XCTAssertThrowsError(try decode(timeZone: "Invalid/Zone"))
        for key in ["id", "name", "address", "phoneNumber"] {
            XCTAssertThrowsError(try decode(overrides: [key: "  "]))
        }
    }

    func testRequiresMinuteInAPIResponse() {
        XCTAssertThrowsError(try decode(omitMinute: true)) { error in
            guard case DecodingError.keyNotFound = error else {
                return XCTFail("Expected keyNotFound, received \(error)")
            }
        }
    }

    private func decode(
        hour: Int = 22,
        minute: Int = 0,
        timeZone: String = "Europe/Moscow",
        overrides: [String: String] = [:],
        omitMinute: Bool = false
    ) throws -> Store {
        var opening = ["hour": hour, "minute": minute]
        if omitMinute { opening.removeValue(forKey: "minute") }
        var payload: [String: Any] = [
            "id": "store", "name": "Лапка", "address": "Воронеж", "phoneNumber": "+7 (000) 000-00-00",
            "timeZone": timeZone,
            "workingHours": ["opening": opening, "closing": ["hour": 6, "minute": 30]]
        ]
        for (key, value) in overrides { payload[key] = value }
        return try JSONDecoder().decode(Store.self, from: JSONSerialization.data(withJSONObject: payload))
    }
}
