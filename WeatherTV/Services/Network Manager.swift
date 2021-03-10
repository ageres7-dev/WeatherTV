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
    
    func fetchCurrentWeather(completion: @escaping (_ weather: CurrentWeather)->()) {
        
    }
    
}


enum Constans: String {
    case testURL = ""
}
