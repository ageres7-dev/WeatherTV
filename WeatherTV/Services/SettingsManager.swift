//
//  SettingsManager.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 20.07.2021.
//

import Combine

final class SettingsManager: ObservableObject {
    @Published var settings: Settings
    
    static let shared = SettingsManager()
  
    private init() {
        settings = DataManager.shared.loadSettings()
    }
    
    init (settings: Settings) {
        self.settings = settings
    }
}
