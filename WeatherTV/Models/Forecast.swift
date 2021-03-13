//
//  Forecast.swift
//  WeatherTV
//
//  Created by Сергей on 11.03.2021.
//

import Foundation


// MARK: - Forecast
struct Forecast: Decodable, Hashable {
    let cod: String?
    let cnt: Int? //Количество временных меток, возвращенных в ответе API
    let list: [List]?
    let city: City?
    
}
// MARK: - List
struct List: Decodable, Hashable {
//    let id: Int
    let dt: Int?
    let main: Main?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility, pop: Int?
    let sys: SysForecast?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
    }
}


// MARK: - City
struct City: Decodable, Hashable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}


// MARK: - Sys
struct SysForecast: Decodable, Hashable {
    let pod: Pod?
}

enum Pod: String, Decodable {
    case d = "d"
    case n = "n"
}
