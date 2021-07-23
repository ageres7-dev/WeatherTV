//
//  Settings.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 13.07.2021.
//

import Foundation

struct Settings: Codable, Equatable {
    var temperature: TypeTemperature = .c
    var pressure: TypePressure = .mmHg
    var showLocalWeather = true
}
