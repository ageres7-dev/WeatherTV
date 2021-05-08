//
//  DayForecastViewModel.swift
//  WeatherTV
//
//  Created by Сергей on 15.03.2021.
//

import Foundation
class DayForecastViewModel {
    private let daily: Daily?
    
    required init(daily: Daily?) {
        self.daily = daily
    }
}

extension DayForecastViewModel {
//    var dayOfWeek: String {
//        guard let dt = daily?.dt else { return "" }
//        let formatter = DateFormatter()
//        formatter.dateFormat = "E"
//        return formatter.string(from: dt)
//    }
    
    var date: String {
        guard let dt = daily?.dt else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM"
        return formatter.string(from: dt)
    }
    
    var iconName: String {
        DataManager.shared.convert(iconName: daily?.weather?.first?.icon)
    }
    
    
    var temp: String {
        guard let nightTemp = daily?.temp?.night else { return "" }
        guard let dayTemp = daily?.temp?.day else { return "" }
        return "\(lround(dayTemp)) / \(lround(nightTemp))ºС"
    }
    
//    var description: String {
//        guard let description = daily?.weather?.first?.description else { return "" }
//        return description
//    }
    
    private var dayTemp: String {
        guard let dayTemp = daily?.temp?.day else { return "" }
        return "\(lround(dayTemp))ºС"
    }
    
    private var nightTemp: String {
        guard let nightTemp = daily?.temp?.night else { return "" }
        return "\(lround(nightTemp))ºС"
    }
}