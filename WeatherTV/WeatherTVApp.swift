//
//  WeatherTVApp.swift
//  WeatherTV
//
//  Created by Сергей on 08.03.2021.
//

import SwiftUI

@main
struct WeatherTVApp: App {
    let userData = DataManager.shared.loadUserData()
    var body: some Scene {
        WindowGroup {
            StartTabView()
                .environmentObject(LocationManager.shared)
                .environmentObject(UserManager(userData: userData))
        }
    }
}
