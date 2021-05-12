//
//  Current Weather.swift
//  WeatherTV
//
//  Created by Сергей on 09.03.2021.
//

import Foundation

// MARK: - CurrentWeather
struct CurrentWeather: Decodable, Hashable {
    let coord: Coord?
    let weather: [Weather]?
//    let base: String?
    let main: Main?
    let visibility: Int? //Видимость, метр
    let wind: Wind?
    let clouds: Clouds?
    let rain: Rain?
    let snow: Snow?
    let dt: Int? //Время расчета данных, unix, UTC
    let sys: Sys?
    let timezone: Int? //Сдвиг в секундах от UTC
    let id: Int?
    let name: String?
//        let cod: Int?
}

// MARK: - Coord
struct Coord: Decodable, Hashable {
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
struct Main: Decodable, Hashable  {
    let temp: Double?
    let feelsLike: Double?
    let pressure: Double?
    let humidity: Double?
    let tempMin: Double?
    let tempMax: Double?
    let seaLevel: Double?
    let grndLevel: Double?

//    enum CodingKeys: String, CodingKey {
//        case temp
//        case feelsLike = "feels_like"
//        case pressure
//        case humidity
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//        case seaLevel = "sea_level"
//        case grndLevel = "grnd_level"
        
//    }
}

// MARK: - Wind
struct Wind: Decodable, Hashable  {
    let speed: Double?
    let deg: Double?
    let gust: Double?
}

// MARK: - Clouds
struct Clouds: Decodable, Hashable {
    let all: Double?
}

// MARK: - Rain
struct Rain: Decodable, Hashable {
    let oneHours: Double? //Объем дождя за последний 1 час, мм
    let threeHours: Double? //Объем дождя за последние 3 часа, мм
    enum CodingKeys: String, CodingKey {
        case oneHours = "1h"
        case threeHours = "3h"
    }
}

// MARK: - Snow
struct Snow: Decodable, Hashable {
    let oneHours: Double?
    let threeHours: Double?
    enum CodingKeys: String, CodingKey {
        case oneHours = "1h"
        case threeHours = "3h"
    }
}


// MARK: - Sys
struct Sys: Decodable, Hashable {
//    let type, id: Int?
//    let message: Double?
    let country: String?
    let sunrise: Date?
    let sunset: Date?
}




