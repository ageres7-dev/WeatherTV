//
//  Key API.swift
//  WeatherTV
//
//  Created by Сергей on 10.03.2021.
//

import Foundation

struct URLManager {
    
    static func urlOneCallFrom(latitude: Double, longitude: Double) -> URL? {
        let queryItems = [
            URLQueryItem(name: "exclude", value: "minutely,hourly,alerts"),
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "appid", value: API.key.rawValue),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: getCurrentLocaleCode())
        ]
        
        var components = URLComponents(string: Constant.oneCallURL.rawValue)
        components?.queryItems = queryItems
        
        return components?.url
    }
    
    static func urlCurrentWeatherFrom(latitude: Double, longitude: Double) -> URL? {
        let queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "appid", value: API.key.rawValue),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: getCurrentLocaleCode())
        ]
        
        var components = URLComponents(string: Constant.currentWeatherURL.rawValue)
        components?.queryItems = queryItems
        
        return components?.url
    }
    
    static func urlForecastFrom(latitude: Double, longitude: Double) -> URL? {
        let queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "appid", value: API.key.rawValue),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: getCurrentLocaleCode())
        ]
        
        var components = URLComponents(string: Constant.forecast.rawValue)
        components?.queryItems = queryItems
        
        return components?.url
    }
    
    private static func getCurrentLocaleCode() -> String {
        let currentLocale = Locale.autoupdatingCurrent.identifier
        switch currentLocale {
        case _ where currentLocale.contains("zh_Hans"):
            return "zh_cn"
        case _ where currentLocale.contains("zh_Hant"):
            return "zh_tw"
        case "pt_BR":
            return currentLocale.lowercased()
        default:
            return String(currentLocale.prefix(2))
        }
    }
    
}
