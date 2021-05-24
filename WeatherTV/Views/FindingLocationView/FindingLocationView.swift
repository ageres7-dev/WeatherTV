//
//  FindingLocaationView.swift
//  WeatherTV
//
//  Created by Сергей on 27.04.2021.
//

import SwiftUI

struct FindingLocationView: View {
    @EnvironmentObject var location: LocationManager
    
    var body: some View {
        VStack {
            if isShowAllowAccess {
                
                VStack {
//                    Text("Please allow access to the location")
                    Text("Turning on location services allows us to show you local weather.")
                        .font(.title2)
                    Button("Open in settings") {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                    
                    Button("location") {
                        location.requestWhenInUseAuthorization()
                    }
                }
                
                
            } else if isFindingCurrentLocation {
                
                Text("Finding a location")
                    .font(.title2)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                
            } else {
                WeatherView()
            }
        }
    }
}


extension FindingLocationView {
    var isShowAllowAccess: Bool {
        location.status == .denied
    }
    
    var isFindingCurrentLocation: Bool {
        location.location == nil && !isShowAllowAccess
    }
}

struct FindingLocaationView_Previews: PreviewProvider {
    static var previews: some View {
        FindingLocationView()
            .environmentObject(LocationManager.shared)
    }
}
