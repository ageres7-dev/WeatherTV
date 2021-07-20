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
    
    func urlOneCallFrom(latitude: Double, longitude: Double) -> URL? {
        let queryItems = [
            URLQueryItem(name: "exclude", value: "minutely,hourly,alerts"),
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "appid", value: API.key.rawValue),
            URLQueryItem(name: "units", value: "metric"),
        ]
        
        var components = URLComponents(string: Constant.oneCallURL.rawValue)
        components?.queryItems = queryItems
        
        return components?.url
    }
    
    func urlCurrentWeatherFrom(latitude: Double, longitude: Double) -> URL? {
        let queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "appid", value: API.key.rawValue),
            URLQueryItem(name: "units", value: "metric"),
        ]
        
        var components = URLComponents(string: Constant.currentWeatherURL.rawValue)
        components?.queryItems = queryItems
        
        return components?.url
    }
    
}
