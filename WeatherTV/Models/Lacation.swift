//
//  Lacation.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 04.06.2021.
//

import Foundation
import CoreLocation

struct Location: Codable {
    let name: String?
    let latitude: String
    let longitude: String
    var dateOfLastUpdate: Date?
}




extension Location {
    static var orenburg: Location {
        Location(name: "Orenburg",
                 latitude: "51.46",
                 longitude: "55.06",
                 dateOfLastUpdate: nil)
    }
    
    static func getFrom(_ placemark: CLPlacemark) -> Location {
        Location(
            name: placemark.locality,
            latitude: String(placemark.location?.coordinate.latitude ?? 0),
            longitude: String(placemark.location?.coordinate.longitude ?? 0),
            dateOfLastUpdate: nil
        )
    }
    
    static func getFrom(_ location: CLLocation) -> Location {
        Location(
            name: nil,
            latitude: String(location.coordinate.latitude),
            longitude: String(location.coordinate.longitude),
            dateOfLastUpdate: nil
        )
    }
}
