//
//  ForecastForSevenDays.swift
//  WeatherTV
//
//  Created by Сергей on 14.03.2021.
//

import Foundation



// MARK: - ForecastForSevenDays
struct ForecastOneCalAPI: Codable {
    let lat, lon: Double?
    let timezone: String?
    let timezoneOffset: Date?
    let daily: [Daily]?

//    enum CodingKeys: String, CodingKey {
//        case lat, lon, timezone
//        case timezoneOffset = "timezone_offset"
//        case daily
//    }
}

// MARK: - Daily
struct Daily: Codable, Hashable {
//    var id = UUID()
    let dt: Date?
    let sunrise: Date?
    let sunset: Date?
    let temp: Temp?
    let feelsLike: FeelsLike?
    let pressure: Double?
    let humidity: Double?
    let dewPoint: Double?
    let windSpeed: Double?
    let windDeg: Double?
    let weather: [Weather]?
    let clouds: Double?
    let pop: Double?
    let uvi: Double?
    let snow: Double?

//    enum CodingKeys: String, CodingKey {
//        case dt, sunrise, sunset, temp
//        case feelsLike = "feels_like"
//        case pressure, humidity
//        case dewPoint = "dew_point"
//        case windSpeed = "wind_speed"
//        case windDeg = "wind_deg"
//        case weather, clouds, pop, uvi, snow
//    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable, Hashable {
    let day, night, eve, morn: Double?
}

// MARK: - Temp
struct Temp: Codable, Hashable{
    let day, min, max, night: Double?
    let eve, morn: Double?
}

//// MARK: - Weather
//struct Weather: Codable {
//    let id: Int?
//    let main, weatherDescription, icon: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, main
//        case weatherDescription = "description"
//        case icon
//    }
//}
