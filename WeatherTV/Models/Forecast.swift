//
//  Forecast.swift
//  WeatherTV
//
//  Created by Сергей on 11.03.2021.
//

import Foundation

//Данные прогноза на 5 дней / 3 часа

// MARK: - Forecast
struct Forecast: Decodable, Hashable {
    let cod: String?
    //Количество временных меток, возвращенных в ответе API
    let cnt: Int?
    let list: [List]?
    let city: City?
}

extension Forecast {
    // MARK: - List
    struct List: Decodable, Hashable {
        let dt: Int?
        let main: Main?
        let weather: [Weather]?
        let clouds: Clouds?
        let wind: Wind?
        let visibility: Double?
        let pop: Double?
        let sys: SysForecast?
        let dtTxt: String?
        
        enum CodingKeys: String, CodingKey {
            case dt
            case main
            case weather
            case clouds
            case wind
            case visibility
            case pop
            case sys
            case dtTxt = "dt_txt"
        }
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
