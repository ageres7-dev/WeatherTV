//
//  Ext + Color.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 24.05.2021.
//

import SwiftUI

extension Color {
    
    static let lightBlue = Color(red: 145/255, green: 201/255, blue: 224/255)
    static let lightGreen = Color(red: 145/255, green: 201/255, blue: 171/255)
    static let lightYellow = Color(red: 224/255, green: 214/255, blue: 133/255)
    
}


extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
