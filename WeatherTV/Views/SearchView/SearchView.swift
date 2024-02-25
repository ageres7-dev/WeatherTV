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
    @Binding var isCleanText: Bool
    
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
            guard !text.isEmpty else {
                cities = []
                return
            }
            location.findLocation(from: text) { placemarks in
                guard let placemarks, !state.text.isEmpty else {
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
            
            alertText = "This city has already been added.".localized()
            selection = newLocation.tag
            isShowAlert.toggle()
            isCleanText.toggle()
            return
        }
        guard locations.count <= 4 else {
            alertText = "Maximum locations reached.".localized()
            isShowAlert.toggle()
            isCleanText.toggle()
            return
        }

        locations.append(newLocation)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            selection = newLocation.tag
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isCleanText.toggle()
        }

    }
    
    private func locationString(from city: CLPlacemark) -> String {
        city.getTag()
    }
    
    private var filteredCitiesFound: [CLPlacemark] {
        cities.filter({ $0.locality != nil })
    }
    
}
