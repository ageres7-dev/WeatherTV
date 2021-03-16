//
//  DayForecastViewModel.swift
//  WeatherTV
//
//  Created by Сергей on 15.03.2021.
//

import Foundation
class DayForecastViewModel {
    
    var dayOfWeek: String {
        guard let dt = daily?.dt else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: dt)
    }
    
    var date: String {
        guard let dt = daily?.dt else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM"
        return formatter.string(from: dt)
    }
    
    var iconName: String {
//        guard let icon = daily?.weather?.first?.icon else { return "" }
//        return icon
        DataManager.shared.convert(iconName: daily?.weather?.first?.icon)
    }
    
    var dayTemp: String {
        guard let dayTemp = daily?.temp?.day else { return "" }
        return "\(lround(dayTemp))ºС"
    }
    
    var nightTemp: String {
        guard let nightTemp = daily?.temp?.night else { return "" }
        return "\(lround(nightTemp))ºС"
    }
    
    var temp: String {
        guard let nightTemp = daily?.temp?.night else { return "" }
        guard let dayTemp = daily?.temp?.day else { return "" }
        return "\(lround(dayTemp)) / \(lround(nightTemp))ºС"
    }
    
    var description: String {
        guard let description = daily?.weather?.first?.description else { return "" }
        return description
    }
    
    private let daily: Daily?
    
    required init(daily: Daily?) {
        self.daily = daily
    }
}
