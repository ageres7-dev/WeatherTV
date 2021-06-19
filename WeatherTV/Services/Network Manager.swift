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
    
    func fetchCurrentWeather(from url: URL?, completion: @escaping (_ weather: CurrentWeather)->()) {
        guard let url = url else { return }
//        print(url)
        fetchObject(CurrentWeather.self, from: url) { weather in
            completion(weather)
        }

    }
    
    
    func fetchForecast(from url: URL?, completion: @escaping (_ forecast: Forecast)->()) {
        guard let url = url else { return }
        
        
        fetchObject(Forecast.self, from: url) { forecast in
            completion(forecast)
        }
    
    }
    
    
    func fetchForecastSevenDays(from url: URL?, completion: @escaping (_ forecast: ForecastOneCalAPI)->()) {
        guard let url = url else { return }
//        print(url)
        fetchObject(ForecastOneCalAPI.self, from: url) { forecast in
            completion(forecast)
        }
    }
    
    
    func fetchCitys(complition: @escaping ([City]) -> Void) {
        let url = Bundle.main.url(forResource: "city.list.json", withExtension: nil)
        fetchObject([City].self, from: url) { citys in
            complition(citys)
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
