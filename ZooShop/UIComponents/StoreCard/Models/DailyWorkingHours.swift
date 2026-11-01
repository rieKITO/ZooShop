import Foundation

/// A daily schedule in the store's local time. Equal endpoints mean closed.
struct DailyWorkingHours: Decodable {
    
    struct Time {
        let hour: Int
        let minute: Int

        init(hour: Int, minute: Int = 0) {
            precondition((0..<24).contains(hour) && (0..<60).contains(minute))
            self.hour = hour
            self.minute = minute
        }

        var formatted: String {
            String(format: "%02d:%02d", hour, minute)
        }

        fileprivate var minutesSinceMidnight: Int {
            hour * 60 + minute
        }
    }
    
    // MARK: - Init Properties

    let opening: Time
    let closing: Time
    
    // MARK: - Computed Properties

    var formatted: String {
        "\(opening.formatted)–\(closing.formatted)"
    }
    
    // MARK: - Public Methods

    func contains(minutesSinceMidnight minutes: Int) -> Bool {
        let start = opening.minutesSinceMidnight
        let end = closing.minutesSinceMidnight
        if start > end {
            return minutes >= start || minutes < end
        }
        return minutes >= start && minutes < end
    }

}

// MARK: - Decodable

extension DailyWorkingHours.Time: Decodable {
    private enum CodingKeys: String, CodingKey {
        case hour, minute
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let hour = try container.decode(Int.self, forKey: .hour)
        let minute = try container.decode(Int.self, forKey: .minute)
        guard (0..<24).contains(hour) else {
            throw DecodingError.dataCorruptedError(
                forKey: .hour, in: container, debugDescription: "Hour must be between 0 and 23."
            )
        }
        guard (0..<60).contains(minute) else {
            throw DecodingError.dataCorruptedError(
                forKey: .minute, in: container, debugDescription: "Minute must be between 0 and 59."
            )
        }
        self.init(hour: hour, minute: minute)
    }
}
