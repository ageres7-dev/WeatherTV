//
//  StartTabView.swift
//  WeatherTV
//
//  Created by Сергей on 14.03.2021.
//

import SwiftUI

struct StartTabView: View {
    @EnvironmentObject var manager: UserManager
    @State private var nameCurrentLocation = "My Location"
    @State private var weatherConditionID: Int? = nil
    @State private var isShowLocalWeather = false
    @State private var isCleanText = false
    @ObservedObject var state = SearchState()
    
    var body: some View {
        NavigationView {
            ZStack {
                WeatherBackground(conditionID: weatherConditionID)
                    .ignoresSafeArea()
                
                TabView(selection: $manager.userData.selectedTag) {
                    Group {
                        if isShowSearchView {
                            SearchWrapper(
                                SearchView(state: state,
                                           locations: $manager.userData.locations,
                                           selection: $manager.userData.selectedTag,
                                           isCleanText: $isCleanText),
                                state: state,
                                isCleanText: $isCleanText
                            )
                        } else {
                            DisabledSearchMessageView()
                        }
                    }
                    .tabItem { Image(systemName: "magnifyingglass") }
                    .tag("search")
                    
                    if isShowLocalWeather {
                        if let currentLocation = currentLocation {
                            WeatherView(viewModel: WeatherViewModel(location: currentLocation ), weatherConditionID: $weatherConditionID,
                                        selection: $manager.userData.selectedTag)
                                
                                .tabItem {
                                    Label(nameCurrentLocation, systemImage: "location")
                                }
                                .tag(Constant.tagCurrentLocation.rawValue)
                        }
                        
                    } else {
                        FindingLocationView(selection: $manager.userData.selectedTag,
                                            nameCurrentLocation: $nameCurrentLocation,
                                            weatherConditionID: $weatherConditionID, isShowLocalWeather: $isShowLocalWeather)
                            .tabItem {
                                Label(nameCurrentLocation, systemImage: "location")
                            }
                            .tag(Constant.tagCurrentLocation.rawValue)
                    }
                    
                    ForEach(locations) { location in
                        WeatherView(viewModel: WeatherViewModel(location: location), weatherConditionID: $weatherConditionID,
                                    selection: $manager.userData.selectedTag)
                            .tabItem {
                                Text(location.name ?? "")
                            }
                            .tag(location.tag)
                    }
                    
                    
                    SettingsView(temperature: $manager.userData.settings.temperature,
                                 pressure: $manager.userData.settings.pressure)
                        .tabItem { Image(systemName: "gearshape") }
                        .tag("settings")
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

extension StartTabView {
    
    private var isShowSearchView: Bool {
        locations.count < 5
    }
    
    private var currentLocation: Location? {
        manager.userData.locations.first(where: { $0.tag == Constant.tagCurrentLocation.rawValue})
    }
    
    private var locations: [Location] {
        manager.userData.locations.filter({ $0.tag != Constant.tagCurrentLocation.rawValue })
    }
    
}


struct StartTabView_Previews: PreviewProvider {
    static var previews: some View {
        StartTabView()
            .environmentObject(LocationManager.shared)
    }
}
