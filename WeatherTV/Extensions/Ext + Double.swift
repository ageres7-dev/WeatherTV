//
//  Ext + Double.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 20.07.2021.
//

import Foundation

extension Double {
     func kelvinToCelsius() -> Double {
        self - 273.15
    }
    
    mutating func convertCelsiusToFahrenheit() {
        self = (self * 9/5 + 32).rounded()
    }
    
    mutating func convertHPaToMmHg() {
        self = self * 0.75006375541921
    }
}
//
//let x = 1.23556789
//let y = Double(round(1000*x)/1000)
//extension String {
//    func capitalizingFirstLetter() -> String {
//      return prefix(1).uppercased() + self.lowercased().dropFirst()
//    }
//
//    mutating func capitalizeFirstLetter() {
//      self = self.capitalizingFirstLetter()
//    }
//}
