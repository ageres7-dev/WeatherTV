//
//  FindingLocaationView.swift
//  WeatherTV
//
//  Created by Сергей on 27.04.2021.
//

import SwiftUI
import CoreLocation

struct FindingLocationView: View {
    @EnvironmentObject var manager: UserManager
    @EnvironmentObject var location: LocationManager
    @State private var isFirsOnAppear = true
    @Binding var selection: String
    @Binding var nameCurrentLocation: String
    @Binding var weatherConditionID: Int?
    @Binding var isShowLocalWeather: Bool
    
    var body: some View {
        
        VStack {

            if isShowAllowAccess {
                VStack {
                    Text("Turning on location services allows us to show you local weather.")
                        .font(.title2)
                    Button("Open in settings") {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                }
                
            } else if isFindingCurrentLocation {
                
                Text("Finding a location")
                    .font(.title2)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .onAppear {
                        if selection == Constant.tagCurrentLocation.rawValue {
                            location.requestLocation()
                            location.requestWhenInUseAuthorization()
                        }
                    }
                
            } else {
                
                if let placemark = location.placemark {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .onAppear {
                            comparisonOfTheSavedLocationWithThe(currentLocation: placemark)
                        }
                }
            }
        }
        .onChange(of: selection) { selection in
            guard isFirsOnAppear else { return }
            if selection == Constant.tagCurrentLocation.rawValue {
                print(location.status.debugDescription.description )
                location.requestWhenInUseAuthorization()
                print(location.status .debugDescription.description)
                isFirsOnAppear = false
            }
        }
    }
}


extension FindingLocationView {
    private func comparisonOfTheSavedLocationWithThe(currentLocation: CLPlacemark) {
        var currentLocation = Location.getFrom(currentLocation)
        currentLocation.tag = Constant.tagCurrentLocation.rawValue
        
        let index = manager.userData.locations.firstIndex(where: {
            $0.tag == Constant.tagCurrentLocation.rawValue
        })
        
        if let indexCurrentLocation = index {
            let savedLocation = manager.userData.locations[indexCurrentLocation]
            let savedLatitude = (savedLocation.latitude)
            let savedLongitude = (savedLocation.longitude)
            
            print(savedLatitude)
            print(currentLocation.latitude)
            let roundedSavedLatitude = round(1000 * savedLatitude) / 1000
            let roundedSavedLongitude = round(1000 * savedLongitude) / 1000
            
            let roundedCurrentLatitude = round(1000 * currentLocation.latitude) / 1000
            let roundedCurrentLongitude = round(1000 * currentLocation.longitude) / 1000
            
            if roundedSavedLatitude == roundedCurrentLatitude,
                  roundedSavedLongitude == roundedCurrentLongitude {
                
                currentLocation.lastUpdateCurrentWeather = savedLocation.lastUpdateCurrentWeather
                currentLocation.lastUpdateForecastWeather = savedLocation.lastUpdateForecastWeather
                currentLocation.currentWeather = savedLocation.currentWeather
                currentLocation.forecastOneCalAPI = savedLocation.forecastOneCalAPI
            }
        }
        
        manager.userData.locations.removeAll(where: {
            $0.tag == Constant.tagCurrentLocation.rawValue
        })
        
        let startIndex = manager.userData.locations.startIndex
        manager.userData.locations.insert(currentLocation, at: startIndex)
        nameCurrentLocation = currentLocation.name ?? "My Location"
        isShowLocalWeather = true
    }
    
    private func convert(_ placemark: CLPlacemark) -> Location {
        var temp = Location.getFrom(placemark)
        temp.tag = Constant.tagCurrentLocation.rawValue
        return temp
    }
  
    
    private var isShowAllowAccess: Bool {
        location.status == .denied || location.status == .none
    }
    
    private var isFindingCurrentLocation: Bool {
        location.location == nil  || location.status == .none // && !isShowAllowAccess
    }
}


struct FindingLocaationView_Previews: PreviewProvider {
    static var previews: some View {
        FindingLocationView(
            selection: .constant(""),
            nameCurrentLocation: .constant("ee"),
            weatherConditionID: .constant(200),
            isShowLocalWeather: .constant(false)
        )
        
        .environmentObject(LocationManager.shared)
    }
}
