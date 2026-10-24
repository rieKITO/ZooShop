//
//  ImageLoaderEnvironment.swift
//  ZooShop
//
// Created by Aleksandr Potemkin on 22.10.2026.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var imageLoader: any ImageLoading = AppDI.imageLoader
}
