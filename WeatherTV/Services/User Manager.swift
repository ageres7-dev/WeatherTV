//
//  User Manager.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 06.06.2021.
//

import Combine
final class UserManager: ObservableObject {
    static let shared = UserManager()
    
    @Published var userData: UserData
    
    private init() {
        userData = UserData()
    }
    
    private init (userData: UserData) {
        self.userData = userData
    }
   
}

