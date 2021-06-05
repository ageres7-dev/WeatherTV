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
    @EnvironmentObject var location: LocationManager
    @ObservedObject var state: SearchState
    @Binding var locations: [Location]
    @Binding var selection: String
    
    var body: some View {
        
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(cities.filter({ $0.locality != nil }), id: \.self) { city in
                    Button(action: {
                        locations.append(.getFrom(city))
                        selection = city.locality ?? ""
                        state.text = ""
                    }) {
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
        .onChange(of: state.text) { text in
            location.findLocation(from: text) { placemarks in
                guard let placemarks = placemarks else {
                    cities = []
                    return
                }
                cities = placemarks
            }
        }
        .onAppear {
            state.text = ""
        }
        .onDisappear {

            state.text = ""
        }
    }
}

extension SearchView {
    func locationString(from city: CLPlacemark) -> String {
        let locality = city.locality != nil ? "\(city.locality!), " : ""
        let administrativeArea = city.administrativeArea != nil ? "\(city.administrativeArea!), " : ""
        let country = city.country != nil ? "\(city.country!)" : ""
        
        
        return locality + administrativeArea + country
    }
    
    private func actionAddLocation() {
        
    }
}






//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
////        SearchController(searchString: .constant("99"))
//    }
//}
