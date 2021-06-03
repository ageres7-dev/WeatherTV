//
//  StartTabView.swift
//  WeatherTV
//
//  Created by Сергей on 14.03.2021.
//

import SwiftUI

struct StartTabView: View {
    @State private var selection = 0
    @ObservedObject var state = SearchState()
    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $selection) {
                    SearchWrapper(SearchView(state: state), state: state)
                        .tabItem { Image(systemName: "magnifyingglass") }
                        .tag(0)
                    
                    FindingLocationView(selection: $selection)
                        .tabItem {
                            Label("Local Weather", systemImage: "location")
                        }
                        .tag(1)
                    
                    
                }
                .ignoresSafeArea(.all, edges: .top)
            }
            
            LogoDataProvider()
        }
    }
}


struct StartTabView_Previews: PreviewProvider {
    static var previews: some View {
        StartTabView()
            .environmentObject(LocationManager.shared)
    }
}










//                    WeatherView()
//                .tabItem { Image(systemName: "Weather") }

//                    SettingsView()
//                        .tabItem {
//                            Label("Settings", systemImage: "gearshape")
//                        }
//
//
//                    SearchView()
