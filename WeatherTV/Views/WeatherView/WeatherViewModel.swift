//
//  WeatherViewModel.swift
//  WeatherTV
//
//  Created by Сергей on 10.03.2021.
//

import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published var currenWeather: CurrentWeather?
    var dailyForecasts: [Daily] {
        guard var daily = forecastOneCalAPI?.daily else { return [] }
        
        daily.sort {
            guard let first = $0.dt, let second = $1.dt else { return false }
            return first < second
        }
        daily.remove(at: 0)
        return daily
    }
    
    var locationName: String {
        if let city = currenWeather?.name,
           let country = currenWeather?.sys?.country {
            return "\(city), \(country)"
        } else {
            return "N/A"
        }
 
    }
    
    var discription: String {
        currenWeather?.weather?.first?.description ?? "N/A"
    }
    
    var main: String {
        currenWeather?.weather?.first?.main ?? "N/A"
    }
    
    var temp: String {
        guard let temp = currenWeather?.main?.temp else { return "N/A" }
        return "\(lround(temp))ºc"
    }
    
    var humidity: String {
        var result = ""
        if let humidity = currenWeather?.main?.humidity {
            result = "Humidity: \(lround(humidity))%"
        }
        return result
    }
    
    var feelsLike: String {
        guard let feelsLike = currenWeather?.main?.feelsLike else { return "N/A" }
        return "Feels like: \(lround(feelsLike))ºc"
    }
    
    var pressure: String {
        guard let pressure = currenWeather?.main?.pressure else { return "N/A" }
        return "Pressure: \(lround(pressure)) hPa"
    }
    
    var icon: String {
        guard let icon = currenWeather?.weather?.first?.icon else { return "thermometer" }
        return DataManager.shared.convert(iconName: icon)
        //"arrow.clockwise"
    }
    
    

    private var forecastOneCalAPI: ForecastOneCalAPI?
    
    func fetchForecast() {
        NetworkManager.shared.fetchForecastSevenDays(from: Constant.testForecastSevenDays.rawValue) { forecast in
            self.forecastOneCalAPI = forecast
            print("fetchForecastSevenDays")
        }
    }
    
   
    func fetchCurrentWeather() {
        NetworkManager.shared.fetchCurrentWeather(from: Constant.testCurrentWeatherURL.rawValue) { currentWeather in
            self.currenWeather = currentWeather
            print("fetchCurrentWeather")
            self.fetchForecast()
        }
    }
    
}
