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
    
    func fetchCurrentWeather(
        from url: URL?,
        completion: @escaping (_ weather: CurrentWeather) -> ()
    ) {
        guard let url = url else { return }

        fetchObject(CurrentWeather.self, from: url) { weather in
            completion(weather)
        }
    }
    
    func fetchForecast(
        from url: URL?,
        completion: @escaping (_ forecast: Forecast) -> ()
    ) {
        guard let url = url else { return }
        
        fetchObject(Forecast.self, from: url) { forecast in
            completion(forecast)
        }
    }
    
    func fetchForecastSevenDays(
        from url: URL?,
        completion: @escaping (_ forecast: ForecastOneCalAPI) -> ()
    ) {
        guard let url = url else { return }
        fetchObject(ForecastOneCalAPI.self, from: url) { forecast in
            completion(forecast)
        }
    }

    /// Сериалзация json файла полученного по url
    private func fetchObject<T: Decodable>(_ type: T.Type, from url: URL?, completion: @escaping (_ object: T)->()) {
        
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                let decode = JSONDecoder()
                decode.keyDecodingStrategy = .convertFromSnakeCase
                decode.dateDecodingStrategy = .secondsSince1970
                let object = try decode.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(object)
                }
            } catch let error {
                print("Error serialization json", error.localizedDescription)
            }
        }.resume()
    }
    
}
