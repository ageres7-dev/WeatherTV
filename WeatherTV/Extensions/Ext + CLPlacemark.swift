//
//  Ext + CLPlacemark.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 05.06.2021.
//

import CoreLocation

extension CLPlacemark {
     func getTag() -> String {
        let locality = locality != nil ? "\(locality!), " : ""
        let administrativeArea = administrativeArea != nil ? "\(administrativeArea!), " : ""
        let country = country != nil ? "\(country!)" : ""
        
        return locality + administrativeArea + country
    }
}
