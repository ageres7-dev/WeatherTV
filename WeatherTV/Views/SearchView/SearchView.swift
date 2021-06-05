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
    @State private var isShowAlertDeniedAdding = false
    @State private var isShowAlertMaximumAmount = false
    @EnvironmentObject var location: LocationManager
    @ObservedObject var state: SearchState
    @Binding var locations: [Location]
    @Binding var selection: String
    
    var body: some View {
        
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(cities.filter({ $0.locality != nil }), id: \.self) { city in
                    Button(action: {
                        let newLocation = Location.getFrom(city)
                        guard locations.count <= 5 else {
                            isShowAlertMaximumAmount.toggle()
                            return
                        }
                        guard !locations.contains(where: {
                            $0.tag == newLocation.tag
                        }) else {
                            isShowAlertDeniedAdding.toggle()
                            return
                        }
                        
                        locations.append(newLocation)
                        selection = newLocation.tag
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
        .alert(isPresented: $isShowAlertDeniedAdding) {
            Alert(title: Text("This city has already been added."))
        }
        .alert(isPresented: $isShowAlertMaximumAmount) {
            Alert(title: Text("Maximum locations reached."))
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
        city.getTag()
//        let locality = city.locality != nil ? "\(city.locality!), " : ""
//        let administrativeArea = city.administrativeArea != nil ? "\(city.administrativeArea!), " : ""
//        let country = city.country != nil ? "\(city.country!)" : ""
//
//
//        return locality + administrativeArea + country
    }
    
}








//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
////        SearchController(searchString: .constant("99"))
//    }
//}
