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
    
    /*
    
    Text("\(viewModel.currenWeather?.name ?? "")")
        .bold()
    Text("\(viewModel.currenWeather?.weather?.first?.main ?? "")")
    Text("\(viewModel.currenWeather?.weather?.first?.description ?? "")")
//                    Text("\(viewModel.currenWeather?.rain?.oneHours)")
    Text("\( lround(viewModel.currenWeather?.main?.temp ?? 0) )º")
    */
    func fetchCurrentWeather() {
        NetworkManager.shared.fetchCurrentWeather(from: Constant.testCurrentWeatherURL.rawValue) { currentWeather in
            self.currenWeather = currentWeather
        }
    }
}
