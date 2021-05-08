//
//  Key API.swift
//  WeatherTV
//
//  Created by Сергей on 10.03.2021.
//

import Foundation


class URLManager {
    static let shared = URLManager()
    private init() {}
    
    func urlOneCallFrom(latitude: String, longitude: String) -> URL? {
        let queryItems = [
            URLQueryItem(name: "lat", value: latitude),
            URLQueryItem(name: "lon", value: longitude),
            URLQueryItem(name: "appid", value: API.key.rawValue),
            URLQueryItem(name: "units", value: "metric"),
        ]
        
        var components = URLComponents(string: Constant.oneCallURL.rawValue)
        components?.queryItems = queryItems
        
        return components?.url
    }
    
    func urlCurrentWeatherFrom(latitude: String, longitude: String) -> URL? {
        let queryItems = [
            URLQueryItem(name: "lat", value: latitude),
            URLQueryItem(name: "lon", value: longitude),
            URLQueryItem(name: "appid", value: API.key.rawValue),
            URLQueryItem(name: "units", value: "metric"),
        ]
        
        var components = URLComponents(string: Constant.currentWeatherURL.rawValue)
        components?.queryItems = queryItems
        
        return components?.url
    }
    
    private enum Constant: String {
        case oneCallURL = "https://api.openweathermap.org/data/2.5/onecall"
        case currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather"
    }
    
}
