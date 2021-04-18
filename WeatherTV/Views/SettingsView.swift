//
//  SettingsView.swift
//  WeatherTV
//
//  Created by Сергей on 31.03.2021.
//

import SwiftUI
import CoreLocation

struct SettingsView: View {
    @StateObject var locationManager = LocationManager.shared
    
    @State private var selectedStrength = "Mild"
    @State private var testBool = false
    let strengths = ["Mild", "Medium", "Mature"]
    
    
    @State private var lititude = 0.0
    @State private var longitude = 0.0
    
    
    var body: some View {
        NavigationView {
            
            
            VStack {
                Text("Latitude: \(lititude)")
                Text("Longitude: \(longitude)")
                
                Text("Latitude: \(Double(locationManager.location?.coordinate.latitude ?? 0))")
                Text("Longitude: \(Double(locationManager.location?.coordinate.longitude ?? 0))")
            }
            
            }
            .navigationTitle("Select your cheese")
        }
    }


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
