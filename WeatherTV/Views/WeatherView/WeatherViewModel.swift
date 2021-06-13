//
//  WeatherViewModel.swift
//  WeatherTV
//
//  Created by Сергей on 10.03.2021.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather?
    @Published var forecastOneCalAPI: ForecastOneCalAPI?
    @Published var conditionCode: Int?
    let location: Location
    
    private let userManager = UserManager.shared
    private let locationManager = LocationManager.shared
    
    private var timerAutoUpdate: Timer?
    private let minTimeIntervalUpdateForecast = TimeInterval(60 * 60 * 4) // 4 часа 60 * 60 * 4
    private let minTimeIntervalUpdateCurrentWeather = TimeInterval(60 * 15) //15 минут 60 * 15
    private let timeIntervalUpdateWeather: Double = 60 * 16 //16 минут 60 * 15
    
    private var indexOfCurrentItem: Int? {
        userManager.userData.locations.firstIndex { $0.id == location.id }
    }
    
    init(location: Location) {
        self.location = location
    }
    
    func onAppearAction() {
        guard location.tag == userManager.userData.selectedTag else { return }
        getCurrentWeatherIfEnoughTimeHasPassed()
        getForecastIfEnoughTimeHasPassed()
    }
    
    private func getCurrentWeatherIfEnoughTimeHasPassed() {
        let currentDate = Date()
        guard let indexOfCurrentItem = indexOfCurrentItem else { return }
        guard let dateLastUpdateCurrentWeather = userManager.userData.locations[indexOfCurrentItem].lastUpdateCurrentWeather else {
            fetchCurrentWeather()
            return
        }
        let intervalSinceLastUpdateCurrentWeather = currentDate.timeIntervalSince(dateLastUpdateCurrentWeather)
        
        print("\nintervalSinceLastUpdateCurrentWeather \(intervalSinceLastUpdateCurrentWeather)")
        print("\(intervalSinceLastUpdateCurrentWeather / 60) минут")
        if intervalSinceLastUpdateCurrentWeather > minTimeIntervalUpdateCurrentWeather {
            fetchCurrentWeather()
        } else {
            if currentWeather == nil {
                currentWeather = userManager.userData.locations[indexOfCurrentItem].currentWeather
            }
        }
    }
    
    private func getForecastIfEnoughTimeHasPassed() {
        let currentDate = Date()
        guard let indexOfCurrentItem = indexOfCurrentItem else { return }
        guard let dateLastUpdateForecast = userManager.userData.locations[indexOfCurrentItem].lastUpdateForecastWeather else {
            fetchForecast()
            return
        }
        
        let intervalSinceLastUpdateForecast = currentDate.timeIntervalSince(dateLastUpdateForecast)
        print("\nintervalSinceLastUpdateForecast \(intervalSinceLastUpdateForecast)")
        print("\(intervalSinceLastUpdateForecast / 60) минут")
        if intervalSinceLastUpdateForecast > minTimeIntervalUpdateForecast {
            fetchForecast()
        } else {
            if forecastOneCalAPI == nil {
                forecastOneCalAPI = userManager.userData.locations[indexOfCurrentItem].forecastOneCalAPI
            }
        }
    }
    
    func deleteAction() {
        guard let indexOfCurrentItem = indexOfCurrentItem else { return }
        
        let indexOfPreviousElement = userManager.userData.locations.index(before: indexOfCurrentItem)
        
        switch indexOfCurrentItem {
        case 0:
            userManager.userData.selectedTag = Constant.tagCurrentLocation.rawValue
            
        case 1... :
            if indexOfPreviousElement >= 0 {
                let tagPreviousElement = userManager.userData.locations[indexOfPreviousElement].tag
                
                userManager.userData.selectedTag = tagPreviousElement
            }
            
        default: return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.userManager.userData.locations.remove(at: indexOfCurrentItem)
        }
        
    }
    
    func startAutoUpdateWeather() {
        guard timerAutoUpdate == nil else { return }
        print("startAutoUpdateWeather()")
        timerAutoUpdate = Timer.scheduledTimer(withTimeInterval: timeIntervalUpdateWeather, repeats: true) { _ in
            print("Действие по таймеру \(self.currentWeather?.name ?? "")")
            self.onAppearAction()
        }
        
    }
        
    func fetchWeather() {
        fetchForecast()
        fetchCurrentWeather()
    }
    
    private func saveCurrentDateUpdateForecast() {
        guard let indexOfCurrentItem = indexOfCurrentItem else { return }
        userManager.userData.locations[indexOfCurrentItem].lastUpdateForecastWeather = Date()
    }
    
    private func saveCurrentDateUpdateCurrentWeather() {
        guard let indexOfCurrentItem = indexOfCurrentItem else { return }
        userManager.userData.locations[indexOfCurrentItem].lastUpdateCurrentWeather = Date()
    }
    
    
    private func fetchForecast() {
        let url = URLManager.shared.urlOneCallFrom(
            latitude: location.latitude,
            longitude: location.longitude
        )
        
        NetworkManager.shared.fetchForecastSevenDays(from: url) { forecast in
            self.forecastOneCalAPI = forecast
            print("fetchForecastSevenDays")
            
            guard let indexOfCurrentItem = self.indexOfCurrentItem else { return }
            self.userManager.userData.locations[indexOfCurrentItem].forecastOneCalAPI = forecast
            self.userManager.userData.locations[indexOfCurrentItem].lastUpdateForecastWeather = Date()
        }
    }
    
    private func fetchCurrentWeather() {
        let url = URLManager.shared.urlCurrentWeatherFrom(
            latitude: location.latitude,
            longitude: location.longitude
        )
        
        NetworkManager.shared.fetchCurrentWeather(from: url) { currentWeather in
            self.currentWeather = currentWeather
            self.conditionCode = currentWeather.weather?.first?.id
            print("fetchCurrentWeather")
            
            guard let indexOfCurrentItem = self.indexOfCurrentItem else { return }
            self.userManager.userData.locations[indexOfCurrentItem].currentWeather = currentWeather
            self.userManager.userData.locations[indexOfCurrentItem].lastUpdateCurrentWeather = Date()
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
    var isShowDeleteBotton: Bool {
        location.tag != Constant.tagCurrentLocation.rawValue
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
    
    //
    //    var locationName: String? {
    //
    //        if let location = location.name {
    //            return location
    //        } else if  let locality = locationManager.placemark?.locality {
    //            return locality
    //        } else if let locationFromCurrentWeather = currentWeather?.name {
    //            return "\(locationFromCurrentWeather), \(currentWeather?.sys?.country ?? "")"
    //        } else {
    //            return nil
    //        }
    //    }
    
    var description: String {
        var description = ""
        if let descriptionCurrentWeather = currentWeather?.weather?.first?.description {
            description = descriptionCurrentWeather
        } else if let descriptionOneCall = forecastOneCalAPI?.current?.weather?.first?.description {
            description = descriptionOneCall
        }
        description.capitalizeFirstLetter()
        return description
    }
    
    var main: String {
        currentWeather?.weather?.first?.main ?? "-"
    }
    
    var temp: String? {
        var temperature: String?
        
        if let temp = currentWeather?.main?.temp {
            temperature = " \(lround(temp))º"
        } else if let temp = forecastOneCalAPI?.current?.temp {
            temperature = " \(lround(temp))º"
        }
        return temperature
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
    
    
    var icon: String? {
        var iconName: String?
        
        if let icon = currentWeather?.weather?.first?.icon {
            iconName = icon
        } else if let icon = forecastOneCalAPI?.current?.weather?.first?.icon {
            iconName = icon
        }
        
        return iconName?.convertWeatherIconName()
    }
    
    var sunsetTime: String? {
        guard let date = currentWeather?.sys?.sunset else { return nil }
        guard let timeZone = currentWeather?.timezone else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: timeZone)
        return "Sunset time: \(formatter.string(from: date))"
    }
    
    var sunriseTime: String? {
        guard let date = currentWeather?.sys?.sunrise else { return nil }
        guard let timeZone = currentWeather?.timezone else { return nil }
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: timeZone)
        formatter.dateFormat = "HH:mm"
        return "Sunrise time: \(formatter.string(from: date))"
    }
    
    var weatherConditionID: Int? {
        currentWeather?.weather?.first?.id
    }
}
