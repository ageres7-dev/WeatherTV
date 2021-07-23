//
//  DayForecastViewModel.swift
//  WeatherTV
//
//  Created by Сергей on 15.03.2021.
//

import Foundation
class DayForecastViewModel {
    private let settings = SettingsManager.shared
    private var isFahrenheit: Bool {
        settings.settings.temperature == .f
    }
    
    var unitsTemp: String {
        isFahrenheit ? "ºF" : "ºC"
    }
    
    private let daily: Daily?
    
    required init(daily: Daily?) {
        self.daily = daily
    }
}

extension DayForecastViewModel {
    
    var date: String {
        guard let dt = daily?.dt else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM"
        return formatter.string(from: dt)
    }
    
    var iconName: String? {
        daily?.weather?.first?.icon?.convertWeatherIconName()
    }
    
    
    var temp: String {
        guard var nightTemp = daily?.temp?.night,
              var dayTemp = daily?.temp?.day else { return "" }
        
        if isFahrenheit {
            nightTemp.convertCelsiusToFahrenheit()
            dayTemp.convertCelsiusToFahrenheit()
        }
        
        
        return "\(lround(dayTemp)) / \(lround(nightTemp))\(unitsTemp)"
    }

    private var dayTemp: String {
        guard var dayTemp = daily?.temp?.day else { return "" }
        if isFahrenheit {
            dayTemp.convertCelsiusToFahrenheit()
        }
        return "\(lround(dayTemp))\(unitsTemp)"
    }
    
    private var nightTemp: String {
        guard var nightTemp = daily?.temp?.night else { return "" }
        if isFahrenheit {
            nightTemp.convertCelsiusToFahrenheit()
        }
        
        return "\(lround(nightTemp))\(unitsTemp)"
    }
}
