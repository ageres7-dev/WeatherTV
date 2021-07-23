//
//  UserData.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 06.06.2021.
//

import Foundation

struct UserData: Codable, Equatable {
    var locations: [Location] = []
    var selectedTag: String = "My Location"
//    var settings: Settings = Settings(temperature: .c, pressure: .hPa)
}
