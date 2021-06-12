//
//  SearchView.swift
//  WeatherTV
//
//  Created by Сергей on 17.04.2021.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    @State private var cities: [CLPlacemark] = []
    @State private var isShowAlert = false
    @State private var alertText = "Oops"
    @EnvironmentObject var location: LocationManager
    @ObservedObject var state: SearchState
    @Binding var locations: [Location]
    @Binding var selection: String
    
    var body: some View {
        
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(filteredCitiesFound, id: \.self) { city in
                    Button(action: { addLocationToList(from: city) }) {
                        HStack(spacing: 16) {
                            Image(systemName: "plus.circle")
                            Text(locationString(from: city))
                        }
                        .font(.title3)
                    }
                    .transition(.opacity)
                }
            }
            .padding(.top)
        }
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text(alertText))
        }
        .onChange(of: state.text) { text in
            location.findLocation(from: text) { placemarks in
                guard let placemarks = placemarks else {
                    cities = []
                    return
                }
                cities = placemarks
            }
        }
    }
}

extension SearchView {
    
    private func addLocationToList(from city: CLPlacemark) {
        let newLocation = Location.getFrom(city)
        guard !locations.contains(where: {
            $0.tag == newLocation.tag
        }) else {
            alertText = "This city has already been added."
            isShowAlert.toggle()
            return
        }
        guard locations.count <= 5 else {
            alertText = "Maximum locations reached."
            isShowAlert.toggle()
            return
        }

        locations.append(newLocation)
        selection = newLocation.tag
        state.text = ""
    }
    
    private func locationString(from city: CLPlacemark) -> String {
        city.getTag()
        //        let name = city.name ?? ""
        //        let locality = city.locality != nil ? "\(city.locality!), " : ""
        //        let administrativeArea = city.administrativeArea != nil ? "\(city.administrativeArea!), " : ""
        //        let country = city.country != nil ? "\(city.country!)" : ""
        //        return name + locality + administrativeArea + country
        
        
    }
    private var filteredCitiesFound: [CLPlacemark] {
        cities.filter({ $0.locality != nil })
    }
    
}
