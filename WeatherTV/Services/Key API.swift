//
//  Key API.swift
//  WeatherTV
//
//  Created by Сергей on 10.03.2021.
//

import Foundation

enum KeyAPI: String {
    case openWeatherMap = "5dd2b561e08cf36d5726459eecfe7bd7"
    
}

enum Constant: String {
    case key = "5dd2b561e08cf36d5726459eecfe7bd7"
    
    case testOneCallURL = "https://api.openweathermap.org/data/2.5/onecall?lat=33.441792&lon=-94.037689&appid=5dd2b561e08cf36d5726459eecfe7bd7"
    case testCurrentWeatherURL = "https://api.openweathermap.org/data/2.5/weather?q=orenburg&appid=5dd2b561e08cf36d5726459eecfe7bd7&units=metric" //&lang=ru
    
    case testForecast = "https://api.openweathermap.org/data/2.5/forecast?q=orenburg&appid=5dd2b561e08cf36d5726459eecfe7bd7&units=metric"
    
    
    case testForecastSevenDays = "https://api.openweathermap.org/data/2.5/onecall?lat=51.7727&lon=55.0988&exclude=current,minutely,hourly,alerts&appid=5dd2b561e08cf36d5726459eecfe7bd7&units=metric"
}

//https://api.openweathermap.org/data/2.5/forecast?q=orenburg&appid=5dd2b561e08cf36d5726459eecfe7bd7&units=metric


class URLManager {
    static let shared = URLManager()
    private init() {}
    
    func urlOneCallFrom(latitude: String, longitude: String) -> String {
        "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(Constant.key.rawValue)&units=metric"
    }
    
    
    func urlCurrentWeatherFrom(latitude: String, longitude: String) -> String {
        "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constant.key.rawValue)&units=metric"
    }
}
