//
//  User Manager.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 06.06.2021.
//

import Combine

final class UserManager: ObservableObject {
    @Published var userData: UserData
    
    static let shared = UserManager()
  
    private init() {
        userData = DataManager.shared.loadUserData()
    }
    
    init (userData: UserData) {
        self.userData = userData
    }
}

