//
//  WeatherViewModel.swift
//  WeatherTV
//
//  Created by Сергей on 10.03.2021.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var currenWeather: CurrentWeather?
    
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
        return convert(iconName: icon)
    }
   
    func fetchCurrentWeather() {
        NetworkManager.shared.fetchCurrentWeather(from: Constant.testCurrentWeatherURL.rawValue) { currentWeather in
            self.currenWeather = currentWeather
        }
    }
    
    private func convert(iconName:String) -> String {
        var result = ""
        
        switch iconName {
        case "01d": result = "sun.max"
        case "01n": result = "moon"
        case "02d": result = "cloud.sun"
        case "02n": result = "cloud.moon"
        case "03d": result = "cloud"
        case "03n": result = "cloud"
        case "04d": result = "smoke"
        case "04n": result = "smoke"
        case "09d": result = "cloud.rain"
        case "09n": result = "cloud.rain"
        case "10d": result = "cloud.sun.rain"
        case "10n": result = "cloud.moon.rain"
        case "11d": result = "cloud.bolt.rain"
        case "11n": result = "cloud.bolt.rain"
        case "13d": result = "snow"
        case "13n": result = "snow"
        case "50d": result = "smoke"
        case "50n": result = "smoke"
        default: result = "thermometer"
        }
        
        return result
    }
}
