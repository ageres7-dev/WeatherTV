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
                print("CurrentWeather Error serialization json", error.localizedDescription)
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
                print("Forecast Error serialization json", error.localizedDescription)
                print(data)
            }
        }.resume()
    
    }
    
    
    func fetchForecastSevenDays(from url: String, completion: @escaping (_ forecast: ForecastOneCalAPI)->()) {
        guard let forecastURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: forecastURL) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                let decode = JSONDecoder()
                decode.keyDecodingStrategy = .convertFromSnakeCase
                decode.dateDecodingStrategy = .secondsSince1970
                let forecast = try decode.decode(ForecastOneCalAPI.self, from: data)
                
                DispatchQueue.main.async {
                    completion(forecast)
                }
            } catch let error {
                print("Forecast Error serialization json", error.localizedDescription)
                print(data)
            }
        }.resume()
    
    }
    func fetchCitys(complition: @escaping ([City]) -> Void) {
        let url = Bundle.main.url(forResource: "city.list.json", withExtension: nil)
        fetchObject([City].self, from: url) { citys in
            complition(citys)
        }
    }
    
//    func urlFrom(local file: String) -> URL? {
//        guard let url = self.url(forResource: file, withExtension: nil) else {
//                   fatalError("Failed to locate \(file) in bundle.")
//               }
//    }
    
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
//                print(object)
                DispatchQueue.main.async {
                    completion(object)
                }
            } catch let error {
                print("Error serialization json", error.localizedDescription)
            }
        }.resume()
    }
    
}




extension Bundle {
//    let user = Bundle.main.decode(User.self, from: "data.json")
    
//        func urlFrom(local file: String) -> URL? {
//            guard let url = self.url(forResource: file, withExtension: nil) else {
//                       fatalError("Failed to locate \(file) in bundle.")
//                   }
//        }
    
    
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
