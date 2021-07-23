//
//  Lacation.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 04.06.2021.
//

import CoreLocation

struct Location: Codable, Hashable, Identifiable {
    var id = UUID()
    let name: String?
    let latitude: Double
    let longitude: Double
    var tag: String
    var lastUpdateCurrentWeather: Date?
    var lastUpdateForecastWeather: Date?
    var currentWeather: CurrentWeather?
    var forecastOneCalAPI: ForecastOneCalAPI?
}


extension Location {
    static var orenburg: Location {
        Location(name: "Orenburg",
                 latitude: 51.46,
                 longitude: 55.06,
                 tag: "Orenburg")
    }
    
    static func getFrom(_ placemark: CLPlacemark) -> Location {
        Location(
            name: placemark.locality,
            latitude: placemark.location?.coordinate.latitude ?? 0,
            longitude: placemark.location?.coordinate.longitude ?? 0,
            tag: placemark.getTag()
        )
    }
    
    static func getFrom(_ location: CLLocation, tag: String) -> Location {
        Location(
            name: nil,
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            tag: tag
        )
    }
    
}
