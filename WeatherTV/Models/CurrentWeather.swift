//
//  Current Weather.swift
//  WeatherTV
//
//  Created by Сергей on 09.03.2021.
//

import Foundation

// MARK: - CurrentWeather
struct CurrentWeather: Codable, Hashable {
    let coord: Coord?
    let weather: [Weather]?
    let main: Main?
    let visibility: Int? //Видимость, метр
    let wind: Wind?
    let clouds: Clouds?
    let rain: Rain?
    let snow: Snow?
    let dt: Date? //Время расчета данных, unix, UTC
    let sys: Sys?
    let timezone: Int? //Сдвиг в секундах от UTC
    let id: Int?
    let name: String?
}

// MARK: - Coord
struct Coord: Codable, Hashable {
    let lon: Double?
    let lat: Double?
}

// MARK: - Weather
struct Weather: Codable, Hashable  {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

// MARK: - Main
struct Main: Codable, Hashable  {
    let temp: Double?
    let feelsLike: Double?
    let pressure: Double?
    let humidity: Double?
    let tempMin: Double?
    let tempMax: Double?
    let seaLevel: Double?
    let grndLevel: Double?
}

// MARK: - Wind
struct Wind: Codable, Hashable  {
    let speed: Double?
    let deg: Double?
    let gust: Double?
}

// MARK: - Clouds
struct Clouds: Codable, Hashable {
    let all: Double?
}

// MARK: - Rain
struct Rain: Codable, Hashable {
    let oneHours: Double? //Объем дождя за последний 1 час, мм
    let threeHours: Double? //Объем дождя за последние 3 часа, мм
    enum CodingKeys: String, CodingKey {
        case oneHours = "1h"
        case threeHours = "3h"
    }
}

// MARK: - Snow
struct Snow: Codable, Hashable {
    let oneHours: Double?
    let threeHours: Double?
    enum CodingKeys: String, CodingKey {
        case oneHours = "1h"
        case threeHours = "3h"
    }
}


// MARK: - Sys
struct Sys: Codable, Hashable {
    let country: String?
    let sunrise: Date?
    let sunset: Date?
}




