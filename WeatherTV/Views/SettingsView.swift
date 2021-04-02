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
    
//    let locationFetcher = LocationFetcher()
    
    
    
//    let lm = LocationManager()
//
//    var latitude: String  { return("\(lm.location?.latitude ?? 0)") }
//    var longitude: String { return("\(lm.location?.longitude ?? 0)") }
//    var placemark: String { return("\(lm.placemark?.description ?? "XXX")") }
//    var status: String    { return("\(String(describing: lm.status))") }
    
    var body: some View {
        NavigationView {
            
            
            VStack {
//                Button("Get Location", action: getLocation)
                Text("Latitude: \(lititude)")
                Text("Longitude: \(longitude)")
                
                Text("Latitude: \(Double(locationManager.location?.coordinate.latitude ?? 0))")
                Text("Longitude: \(Double(locationManager.location?.coordinate.longitude ?? 0))")
            }
            
            
            
            
//            HStack {
//
//                VStack {
//                    Button("Start Tracking Location") {
//                        self.locationFetcher.start()
//                    }
//
//                    Button("Read Location") {
//                        if let location = self.locationFetcher.lastKnownLocation {
//                            print("Your location is \(location)")
//                        } else {
//                            print("Your location is unknown")
//                        }
//                    }
//                }
                
//                                VStack {
//                                    Text("Latitude: \(self.latitude)")
//                                    Text("Longitude: \(self.longitude)")
//                    Text("Placemark: \(self.placemark)")
//                    Text("Status: \(self.status)")
//                }
//
//                                Spacer()
//                .frame( height: 900)
//                Form {
//                    Section {
//                        Picker("Strength", selection: $selectedStrength) {
//                            ForEach(strengths, id: \.self) {
//                                Text($0)
//                            }
//                        }
//
//                        Toggle("test", isOn: $testBool)
//                    }
//                }
//                .font(.headline)
            }
            .navigationTitle("Select your cheese")
        }
    }

//extension SettingsView {
//    
//    private func getLocation() {
//        LocationManager.shared.getLocation { location in
////            DispatchQueue.main.async {
////                <#code#>
////            }
//            
//            lititude = Double(location.coordinate.latitude)
//            longitude = Double(location.coordinate.longitude)
//            
//        }
//    }
//}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
