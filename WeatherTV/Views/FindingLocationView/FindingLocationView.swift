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
//    @Binding var nameCurrentLocation: String
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
                        location.requestLocation()
                    }
                
            } else {
                
                if let placemark = location.placemark {
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .onAppear {
                            comparisonOfTheSavedLocationWithThe(currentLocation: placemark)
//                            var currentLocation = Location.getFrom(placemark)
//                            currentLocation.tag = Constant.tagCurrentLocation.rawValue
//
//                            manager.userData.locations.removeAll {
//                                $0.tag == Constant.tagCurrentLocation.rawValue
//                            }
//
//                            let startIndex = manager.userData.locations.startIndex
//                            manager.userData.locations.insert(currentLocation, at: startIndex)
//                            isShowLocalWeather = true
                        }
                    
//                    var location = Location.getFrom(placemark)
//                    location.tag = "localWeather"
                    /*
                    WeatherView(
                        viewModel: WeatherViewModel(location: convert(placemark)),
                        weatherConditionID: $weatherConditionID,
                        selection: $selection
                    )
                    .onAppear {
                        guard let newNameCurrentLocation = placemark.locality else { return }
                        nameCurrentLocation = newNameCurrentLocation
                    }
                    */
                    
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
        guard let indexCurrentLocation = index else { return }
        let savedLocation = manager.userData.locations[indexCurrentLocation]
        
        if currentLocation.latitude != savedLocation.latitude,
           currentLocation.longitude != savedLocation.longitude {
            manager.userData.locations.remove(at: indexCurrentLocation)
            let startIndex = manager.userData.locations.startIndex
            manager.userData.locations.insert(currentLocation, at: startIndex)
        }
        /*
         let x = 1.23556789
         let y = Double(round(1000*x)/1000)
         print(y)  // 1.236
         */
//        
//        manager.userData.locations.removeAll {
//            $0.tag == Constant.tagCurrentLocation.rawValue
//        }
//        
//        let startIndex = manager.userData.locations.startIndex
//        manager.userData.locations.insert(currentLocation, at: startIndex)
        
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
        FindingLocationView(selection: .constant(""), weatherConditionID: .constant(200), isShowLocalWeather: .constant(false))
            .environmentObject(LocationManager.shared)
    }
}
