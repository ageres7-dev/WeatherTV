//
//  WeatherViewModel.swift
//  WeatherTV
//
//  Created by Сергей on 10.03.2021.
//

import Foundation
import CoreLocation

class WeatherViewModel: ObservableObject {
    
    @Published var currenWeather: CurrentWeather?
    @Published var forecastOneCalAPI: ForecastOneCalAPI?

    let location: LocationManager
 
    
    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
        print("Timer fired!")
//        fechWeather()
    }
    
    init() {
        location = LocationManager.shared
    }

    
    var latitude: String {
        guard let coordinate = location.location?.coordinate else { return "" }
        return String(coordinate.latitude)
    }
    
    
    
    var longitude: String {
        guard let coordinate = location.location?.coordinate else { return "" }
        return String(coordinate.longitude)
    }
    
    
    var todayForecasts: String {
        var todayForecasts = ""
        
        guard var daily = forecastOneCalAPI?.daily else { return  "" }
        
        daily.sort {
            guard let first = $0.dt, let second = $1.dt else { return false }
            return first < second
        }
        
        
        if let dayTemp = daily.first?.temp?.day,
           let nightTemp = daily.first?.temp?.night {
            todayForecasts = "\(lround(dayTemp)) / \(lround(nightTemp))ºС"
        }
        return todayForecasts
        
    }
    
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
            return ""
        }
 
    }
    
    var discription: String {
        currenWeather?.weather?.first?.description ?? "-"
    }
    
    var main: String {
        currenWeather?.weather?.first?.main ?? "-"
    }
    
    var temp: String? {
        guard let temp = currenWeather?.main?.temp else { return nil }
        return "\(lround(temp))ºC"
    }
    
    var humidity: String {
        var result = ""
        if let humidity = currenWeather?.main?.humidity {
            result = "Humidity: \(lround(humidity))%"
        }
        return result
    }
    
    var feelsLike: String {
        guard let feelsLike = currenWeather?.main?.feelsLike else { return "-" }
        return "Feels like: \(lround(feelsLike))ºC"
    }
    
    var pressure: String {
        guard let pressure = currenWeather?.main?.pressure else { return "-" }
        return "Pressure: \(lround(pressure)) hPa"
    }
    
    var icon: String {
        guard let icon = currenWeather?.weather?.first?.icon else { return "thermometer" }
        return DataManager.shared.convert(iconName: icon)
        //"arrow.clockwise"
    }
    
    
    
    func fechWeather() {
        fetchForecast()
        fetchCurrentWeather()
    }
    
    func fetchForecast() {
//        guard let location = locationManager.location  else { return }
        
        
        let url = URLManager.shared.urlOneCallFrom(
            latitude: latitude,
            longitude: longitude
        )
        
        NetworkManager.shared.fetchForecastSevenDays(from: url) { forecast in
            self.forecastOneCalAPI = forecast
            print("fetchForecastSevenDays")
        }
    }
    
   
    func fetchCurrentWeather() {
//        guard let location = locationManager.location  else { return }
        
        let url = URLManager.shared.urlCurrentWeatherFrom(
            latitude: latitude,
            longitude: longitude
        )
        
        NetworkManager.shared.fetchCurrentWeather(from: url) { currentWeather in
            self.currenWeather = currentWeather
            print("fetchCurrentWeather")
        }
    }
    
}
