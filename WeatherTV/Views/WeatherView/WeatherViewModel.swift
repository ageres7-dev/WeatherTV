//
//  WeatherViewModel.swift
//  WeatherTV
//
//  Created by Сергей on 10.03.2021.
//

import Foundation
import CoreLocation

class WeatherViewModel: ObservableObject {
    
    @Published var currentWeather: CurrentWeather?
    @Published var forecastOneCalAPI: ForecastOneCalAPI?

    private let location: LocationManager
        
    private var timerUpdateCurrentWeather: Timer?
    private var timerUpdateForecast: Timer?
    private var dateFetching = Date()
    
    private let timeIntervalFetchCurrentWeather: Double = 10 * 60
    private let timeIntervalFetchForecast: Double = 30 * 60
    private let manualUpdateInterval: Double = 0.5 * 60
    
    init() {
        location = LocationManager.shared
//        dateFetching = Date()
//        dataNextLoad = dateFetching.addingTimeInterval(30)
    }
    
    func isEnoughTimeHasPassed() -> Bool {
        let currentDate = Date()
        guard  currentDate > dateFetching.addingTimeInterval(manualUpdateInterval) else {
            print("Меньше 30 сек", dateFetching, currentDate)
            
            return false
        }
        print("Прошло больше 30 сек")
        return true
    }
   
    
    func startAutoUpdateWeather() {
        timerUpdateCurrentWeather = Timer.scheduledTimer(withTimeInterval: timeIntervalFetchCurrentWeather, repeats: true) { _ in
            self.fetchCurrentWeather()
            print("UpdateCurrentWeather \(self.getCurrentDate())")
        }
        
        timerUpdateForecast = Timer.scheduledTimer(withTimeInterval: timeIntervalFetchForecast, repeats: true) { _ in
            self.fetchForecast()
            print("UpdateForecast \(self.getCurrentDate())")
        }
    }
    
    func actionUpdateButton() {
        guard isEnoughTimeHasPassed() else { return }
        fetchWeather()
    }
    
    func fetchWeather() {
        dateFetching = Date()
        fetchForecast()
        fetchCurrentWeather()
    }
    
    func fetchForecast() {
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
        let url = URLManager.shared.urlCurrentWeatherFrom(
            latitude: latitude,
            longitude: longitude
        )
        
        NetworkManager.shared.fetchCurrentWeather(from: url) { currentWeather in
            self.currentWeather = currentWeather
            print("fetchCurrentWeather")
        }
    }
    
    private func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss E, d MMM y"
        return dateFormatter.string(from: date)
    }
    
}

extension WeatherViewModel {
    
    var latitude: String {
        guard let coordinate = location.location?.coordinate else { return "" }
        return String(coordinate.latitude)
    }
    
    var longitude: String {
        guard let coordinate = location.location?.coordinate else { return "" }
        return String(coordinate.longitude)
    }
    
    
    var todayForecasts: String {
        guard let dayTemp = dailyForecasts.first?.temp?.day,
              let nightTemp = dailyForecasts.first?.temp?.night else { return "" }
        
        return "\(lround(dayTemp)) / \(lround(nightTemp))ºС"
    }
    
    var todayDate: String {
        guard let dt = dailyForecasts.first?.dt else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM"
        return formatter.string(from: dt)
    }
    
    var dailyForecasts: [Daily] {
        guard var daily = forecastOneCalAPI?.daily else { return [] }
        guard !daily.isEmpty else { return [] }
        
        daily.sort {
            guard let first = $0.dt, let second = $1.dt else { return false }
            return first < second
        }
        return daily
    }
    
    var forecastFromTomorrow: [Daily] {
        var forecastFromTomorrow = dailyForecasts
        guard !forecastFromTomorrow.isEmpty else { return [] }
        forecastFromTomorrow.removeFirst()
        return forecastFromTomorrow
    }
    
    
    var locationName: String? {
        currentWeather?.name
    }
    /*
    var locationName: String {
        if let city = currentWeather?.name,
           let country = currentWeather?.sys?.country {
            return "\(city), \(country)"
        } else {
            return ""
        }
    }
    */
    var description: String {
        currentWeather?.weather?.first?.description ?? "-"
    }
    
    var main: String {
        currentWeather?.weather?.first?.main ?? "-"
    }
    
    var temp: String? {
        guard let temp = currentWeather?.main?.temp else { return nil }
        return " \(lround(temp))º"
    }
    
    var humidity: String {
        var result = ""
        if let humidity = currentWeather?.main?.humidity {
            result = "Humidity: \(lround(humidity))%"
        }
        return result
    }
    
    var feelsLike: String {
        guard let feelsLike = currentWeather?.main?.feelsLike else { return "" }
        return "Feels like: \(lround(feelsLike))ºC"
    }
    
    var pressure: String {
        guard let pressure = currentWeather?.main?.pressure else { return "" }
        return "Pressure: \(lround(pressure)) hPa"
    }
    
    var icon: String {
        guard let icon = currentWeather?.weather?.first?.icon else { return "thermometer" }
        return DataManager.shared.convert(iconName: icon)
    }
    
    var sunsetTime: String? {
        guard let date = currentWeather?.sys?.sunset else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
//        return formatter.string(from: date)
        return "Sunset time: \(formatter.string(from: date))"
    }
    
    var sunriseTime: String? {
        guard let date = currentWeather?.sys?.sunrise else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
//        return formatter.string(from: date)
        
        return "Sunrise time: \(formatter.string(from: date))"
    }
}
