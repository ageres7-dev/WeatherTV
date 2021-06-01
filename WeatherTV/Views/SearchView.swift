//
//  SearchView.swift
//  WeatherTV
//
//  Created by Сергей on 17.04.2021.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    @EnvironmentObject var location: LocationManager
    @ObservedObject var state: SearchState
    
    @State private var cities: [CLPlacemark] = []
    
    var body: some View {
        
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(cities, id: \.self) { city in
//                    Button(city.name ?? "-", action: { print(city.country ?? "")} )
                    
                    
                    Button(action: {}) {
                        VStack{
                            Text("name: \(city.name ?? "-")")
                            Text("locality \(city.locality ?? "-")")
                            Text("locality \(city.administrativeArea ?? "-")")
                            Text("locality \(city.isoCountryCode ?? "-")")
                            Text("country \(city.country ?? "-")")
                            
                            Text(String((city.location?.coordinate.latitude)!))
                            Text(String((city.location?.coordinate.longitude)!))
//                            Text("latitude \(city.location?.coordinate.latitude ?? "-")")
//                            Text("latitude \(city.location?.coordinate.longitude ?? "-")")
                        }
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
        
        
        
        /*
        VStack(spacing: 0) {
            

            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    if state.text == "" {
                        ForEach(cities, id: \.self) { city in
                            Button(city.name ?? "-", action: { print(city.country ?? "")} )
                        }
                    } else {
                        ForEach(citys.filter({
                            guard let cityName = $0.name else { return false}
                            return cityName.lowercased().contains(state.text.lowercased())
                        }), id: \.self) { city in
                            Button(city.name ?? "-", action: { print(city.country ?? "")} )
                        }
                    }
                }
            }
            
        }
        .onAppear {
            NetworkManager.shared.fetchCitys { citys in
                self.citys = citys
            }
        }
             */
    }
}

//extension SearchView {
//
//}






//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
////        SearchController(searchString: .constant("99"))
//    }
//}
