//
//  ForecastSevenDaysViewModel.swift
//  WeatherTV
//
//  Created by Сергей on 14.03.2021.
//
/*
import Foundation

class ForecastSevenDaysViewModel: ObservableObject {
    private var forecastOneCalAPI: ForecastOneCalAPI?
    
    var dailyForecasts: [Daily] {
        guard var daily = forecastOneCalAPI?.daily else { return [] }
        
        daily.sort {
            guard let first = $0.dt, let second = $1.dt else { return false }
            return first < second
        }
        daily.remove(at: 0)
        return daily
    }
    
    func fetchForecast() {
//        NetworkManager.shared.fetchForecastSevenDays(from: Constant.testForecastSevenDays.rawValue) { forecast in
//            self.forecastOneCalAPI = forecast
//            print("fetchForecastSevenDays")
//        }
    }
}

*/

