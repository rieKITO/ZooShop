//
//  AppInfo.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 29.10.2026.
//

import Foundation

enum AppInfo {
    static let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "—"
}
