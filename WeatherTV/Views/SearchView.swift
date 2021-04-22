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
        VStack(spacing: 0) {
            SearchController(searchString: $search)
            ScrollView(.vertical, showsIndicators: false) {
                
                Button("Get") {
                    NetworkManager.shared.fetchCitys { citys in
                        self.citys = citys
                    }
                }
                
                
                LazyVStack {
                    ForEach(citys, id: \.self) { city in
                        Button(city.name ?? "-", action: {} )
                    }
                }
            }
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
////        SearchController(searchString: .constant("99"))
//    }
//}
