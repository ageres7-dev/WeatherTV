//
//  StartTabView.swift
//  WeatherTV
//
//  Created by Сергей on 14.03.2021.
//

import SwiftUI

struct StartTabView: View {
    @EnvironmentObject var manager: UserManager
//    @State private var locations: [Location] = []
//    @State private var selection = "search"
    @State private var nameCurrentLocation = "My Location"
    @State private var weatherConditionID: Int? = nil
    
    @ObservedObject var state = SearchState()
    
    var body: some View {
        NavigationView {
            ZStack {
                WeatherBackground(conditionID: weatherConditionID)
                    .ignoresSafeArea()
                TabView(selection: $manager.userData.selectedTag) {
                    SearchWrapper(SearchView(state: state,
                                             locations: $manager.userData.locations,
                                             selection: $manager.userData.selectedTag),
                                  state: state)
                        .tabItem { Image(systemName: "magnifyingglass") }
                        .tag("search")
                    
                    FindingLocationView(selection: $manager.userData.selectedTag,
                                        nameCurrentLocation: $nameCurrentLocation,
                                        weatherConditionID: $weatherConditionID)
                        .tabItem {
                            Label(nameCurrentLocation, systemImage: "location")
                        }
                        .tag("localWeather")
                    
                    ForEach(manager.userData.locations) { location in
                        WeatherView(viewModel: WeatherViewModel(location: location), weatherConditionID: $weatherConditionID,
                                    selection: $manager.userData.selectedTag)
                            .tabItem {
                                Text(location.name ?? "")
                            }
                            .tag(location.tag)
                    }
                    
                }
                .ignoresSafeArea(.all, edges: .top)
                
                LogoDataProvider()
            }
   
        }
        .onChange(of: manager.userData) { userData in
            DataManager.shared.save(userData)
        }
    }
}


struct StartTabView_Previews: PreviewProvider {
    static var previews: some View {
        StartTabView()
            .environmentObject(LocationManager.shared)
    }
}




//struct CitiesView: View {
//    @State private var
//    var body: some View {
//
//    }
//}








//                    WeatherView()
//                .tabItem { Image(systemName: "Weather") }

//                    SettingsView()
//                        .tabItem {
//                            Label("Settings", systemImage: "gearshape")
//                        }
//
//
//                    SearchView()
