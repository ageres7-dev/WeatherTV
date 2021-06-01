//
//  StartTabView.swift
//  WeatherTV
//
//  Created by Сергей on 14.03.2021.
//

import SwiftUI

struct StartTabView: View {
    @ObservedObject var state = SearchState()
    var body: some View {
        NavigationView {
        ZStack {
                TabView {
                    FindingLocationView()
                        .tabItem {
                            Label("Local Weather", systemImage: "location")
                        }

//                    TestingSearchView()
                        PageView(SearchView(state: state), state: state)
//                    SearchView(state: state)
                        .tabItem { Image(systemName: "magnifyingglass") }
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
