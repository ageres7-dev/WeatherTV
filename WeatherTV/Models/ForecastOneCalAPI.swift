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
    let current: Current?
    let daily: [Daily]?
}

// MARK: - Daily
struct Daily: Codable, Hashable {
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

struct Current: Codable, Hashable {
    let dt, sunrise, sunset: Date?
    let temp: Double?
    let feelsLike: Double?
    let pressure, humidity: Double?
    let dewPoint: Double?
    let uvi, clouds, visibility: Double?
    let windSpeed: Double?
    let windDeg: Double?
    let windGust: Double?
    let weather: [Weather]?
}
