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
    
    func save(locations: UserData) {
        guard let userData = try? JSONEncoder().encode(locations) else { return }
        self.userData = userData
    }
    
    func loadLocations() -> UserData {
        guard let locations = try? JSONDecoder().decode(UserData.self, from: userData) else {
            return UserData()
        }
        return locations
    }

}

/*
 extension DataManager {
     func save(condition: Сondition) {
         guard let userData = try? JSONEncoder().encode(condition) else { return }
         self.userData = userData
     }
     
     func loadCondition() -> Сondition {
         guard let condition = try? JSONDecoder().decode(Сondition.self, from: userData) else { return Сondition() }
         return condition
     }
     
     func clear(conditionManager: СonditionManager) {
         conditionManager.condition.answer = Answer()
         conditionManager.condition.isTestPassed = false
         UserDefaults.standard.removeObject(forKey: "answer")
     }
 }
 */
