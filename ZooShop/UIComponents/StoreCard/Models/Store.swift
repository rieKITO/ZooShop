//
//  Store.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 30.10.2026.
//

import Foundation

struct Store: Identifiable, Decodable {
    
    // MARK: - Init Properties
    
    let id: String
    let name: String
    let address: String
    let phoneNumber: String
    let workingHours: DailyWorkingHours
    let timeZone: TimeZone
    
    // MARK: - Initialization

    init(
        id: String,
        name: String,
        address: String,
        phoneNumber: String,
        workingHours: DailyWorkingHours,
        timeZone: TimeZone
    ) {
        self.id = id
        self.name = name
        self.address = address
        self.phoneNumber = phoneNumber
        self.workingHours = workingHours
        self.timeZone = timeZone
    }

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
        case id, name, address, phoneNumber, workingHours, timeZone
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        workingHours = try container.decode(DailyWorkingHours.self, forKey: .workingHours)

        for (key, value) in [(CodingKeys.id, id), (.name, name), (.address, address), (.phoneNumber, phoneNumber)] {
            guard !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                throw DecodingError.dataCorruptedError(
                    forKey: key, in: container, debugDescription: "Store field must not be blank."
                )
            }
        }

        let identifier = try container.decode(String.self, forKey: .timeZone)
        guard let timeZone = TimeZone(identifier: identifier) else {
            throw DecodingError.dataCorruptedError(
                forKey: .timeZone, in: container, debugDescription: "Unknown time zone identifier."
            )
        }
        self.timeZone = timeZone
    }

    // MARK: - Public Methods

    func isOpen(at date: Date) -> Bool {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        let components = calendar.dateComponents([.hour, .minute], from: date)
        guard let hour = components.hour, let minute = components.minute else {
            return false
        }
        return workingHours.contains(minutesSinceMidnight: hour * 60 + minute)
    }

}
