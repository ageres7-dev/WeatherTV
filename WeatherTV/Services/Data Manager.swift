//
//  Data Manager.swift
//  WeatherTV
//
//  Created by Сергей on 14.03.2021.
//

import SwiftUI


class DataManager {
    @AppStorage("userData") var userData = Data()
    
    static let shared = DataManager()
    private init() {}
    
    func save(_ userData: UserData) -> Void {
        guard let userData = try? JSONEncoder().encode(userData) else { return }
        self.userData = userData
    }
    
    func loadUserData() -> UserData {
        guard let locations = try? JSONDecoder().decode(UserData.self, from: userData) else {
            return UserData()
        }
        return locations
    }

}
