//
//  SearchView.swift
//  WeatherTV
//
//  Created by Сергей on 17.04.2021.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var state: SearchState
    
    @State private var citys: [City] = []
    
    var body: some View {
        VStack(spacing: 0) {
//            Button("Get") {
//                NetworkManager.shared.fetchCitys { citys in
//                    self.citys = citys
//                }
//            }
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
  
                    ForEach(citys.filter({
                        guard let cityName = $0.name else { return false}
                        return cityName.lowercased().contains(state.text.lowercased())
                    }), id: \.self) { city in
                        Button(city.name ?? "-", action: { print(city.country ?? "")} )
                    }
                    
                }
            }
            
        }
        .onAppear {
            NetworkManager.shared.fetchCitys { citys in
                self.citys = citys
            }
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
////        SearchController(searchString: .constant("99"))
//    }
//}
