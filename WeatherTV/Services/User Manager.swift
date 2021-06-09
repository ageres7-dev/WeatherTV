//
//  User Manager.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 06.06.2021.
//

import Combine
final class UserManager: ObservableObject {
    @Published var userData: UserData
    
    init() {
        userData = UserData()
    }
    
    init (userData: UserData) {
        self.userData = userData
    }
   
}

