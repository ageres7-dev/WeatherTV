//
//  Data Manager.swift
//  WeatherTV
//
//  Created by Сергей on 14.03.2021.
//

import SwiftUI


class DataManager {
    @AppStorage("userData") var userData = Data()
    @AppStorage("settings") var settings = Data()
    
    static let shared = DataManager()
    private init() {}
    
    func save(_ userData: UserData) -> Void {
        guard let userData = try? JSONEncoder().encode(userData) else { return }
        self.userData = userData
    }
    
    func loadUserData() -> UserData {
        guard let userData = try? JSONDecoder().decode(UserData.self, from: userData) else {
            return UserData()
        }
        return userData
    }
    
    
    func save(_ settings: Settings) -> Void {
        guard let settings = try? JSONEncoder().encode(settings) else { return }
        self.settings = settings
    }
    
    func loadSettings() -> Settings {
        guard let settings = try? JSONDecoder().decode(Settings.self, from: settings) else {
            return Settings()
        }
        return settings
    }

}
