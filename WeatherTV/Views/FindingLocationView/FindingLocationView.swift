//
//  FindingLocaationView.swift
//  WeatherTV
//
//  Created by Сергей on 27.04.2021.
//

import SwiftUI

struct FindingLocationView: View {
//    @StateObject private var viewModel = FindingLocationViewModel()
    
    @EnvironmentObject var location: LocationManager
    
    var body: some View {
        VStack {
            if isShowAllowAccess {
                Text("Please allow access to the location")
            } else if isFindingCurrentLocation {
                
                Text("Finding a location")
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
        location.location == nil // && isShowAllowAccess
    }
}

struct FindingLocaationView_Previews: PreviewProvider {
    static var previews: some View {
        FindingLocationView()
    }
}
