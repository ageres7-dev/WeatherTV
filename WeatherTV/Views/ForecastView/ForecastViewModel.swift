//
//  ForecastViewModel.swift
//  WeatherTV
//
//  Created by Сергей on 11.03.2021.
//

import Foundation

class ForecastViewModel: ObservableObject {
    @Published var forecast: Forecast?
    
    
    var isShowingForecast: Bool {
        (forecast?.list) != nil
    }
    
    var dailyForecast: [List] {
        guard let forecasts = forecast?.list else { return [] }
        return forecasts
    }
    
    
    func fetchForecast() {
        NetworkManager.shared.fetchForecast(from: Constant.testForecast.rawValue) { forecast in
            self.forecast = forecast
            print("dsdfsf")
        }
        
        
        
    }
}
