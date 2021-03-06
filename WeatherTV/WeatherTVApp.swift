//
//  WeatherTVApp.swift
//  WeatherTV
//
//  Created by Сергей on 08.03.2021.
//

import SwiftUI

@main
struct WeatherTVApp: App {
    var body: some Scene {
        WindowGroup {
            StartTabView()
                .environmentObject(LocationManager.shared)
                .environmentObject(UserManager.shared)
                .environmentObject(SettingsManager.shared)
        }
    }
}
