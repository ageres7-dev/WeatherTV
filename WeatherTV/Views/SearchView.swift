//
//  SearchView.swift
//  WeatherTV
//
//  Created by Сергей on 17.04.2021.
//

import SwiftUI

struct SearchView: View {
    
    @State private var search = ""
    @State private var citys: [City] = []
    
    var body: some View {
        VStack {
            
//            SearchBar
            Button("Get") {
                NetworkManager.shared.fetchCitys { citys in
                    self.citys = citys
                }
            }
            Text(citys.first?.name ?? "hh" )
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
