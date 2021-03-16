//
//  Data Manager.swift
//  WeatherTV
//
//  Created by Сергей on 14.03.2021.
//

import Foundation

class DataManager {
    static let shared = DataManager()

    private init() {}
    
    func convert(iconName:String?) -> String {
        var result = ""
        
        switch iconName {
        case "01d": result = "sun.max"
        case "01n": result = "moon.stars"
        case "02d": result = "cloud.sun"
        case "02n": result = "cloud.moon"
        case "03d": result = "cloud"
        case "03n": result = "cloud"
        case "04d": result = "smoke"
        case "04n": result = "smoke"
        case "09d": result = "cloud.rain"
        case "09n": result = "cloud.rain"
        case "10d": result = "cloud.sun.rain"
        case "10n": result = "cloud.moon.rain"
        case "11d": result = "cloud.bolt.rain"
        case "11n": result = "cloud.bolt.rain"
        case "13d": result = "snow"
        case "13n": result = "snow"
        case "50d": result = "smoke"
        case "50n": result = "smoke"
        default: result = "thermometer"
        }
        
        return result
    }

    
    
}
