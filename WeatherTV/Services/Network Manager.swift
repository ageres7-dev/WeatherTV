//
//  Network Manager.swift
//  WeatherTV
//
//  Created by Сергей on 09.03.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCurrentWeather(from url: String, completion: @escaping (_ weather: CurrentWeather)->()) {
        guard let weatherURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: weatherURL) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                let decode = JSONDecoder()
                let weather = try decode.decode(CurrentWeather.self, from: data)
                
                DispatchQueue.main.async {
                    completion(weather)
                }
            } catch let error {
                print("Error serialization json", error.localizedDescription)
            }
        }.resume()

    }
    
    
    func fetchForecast(from url: String, completion: @escaping (_ forecast: Forecast)->()) {
        guard let forecastURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: forecastURL) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                let decode = JSONDecoder()
                let forecast = try decode.decode(Forecast.self, from: data)
                
                DispatchQueue.main.async {
                    completion(forecast)
                }
            } catch let error {
                print("Error serialization json", error.localizedDescription)
                print(data)
            }
        }.resume()
    
    }
}
