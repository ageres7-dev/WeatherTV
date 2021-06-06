//
//  UserData.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 06.06.2021.
//

import Foundation

struct UserData: Codable {
    var locations: [Location] = []
    var selectedTag: String = ""
}
