//
//  StartTabView.swift
//  WeatherTV
//
//  Created by Сергей on 14.03.2021.
//

import SwiftUI

struct StartTabView: View {
    @EnvironmentObject var manager: UserManager
    @EnvironmentObject var settings: SettingsManager
    @State private var nameCurrentLocation = "My Location".localized()
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
                            weather(currentLocation: currentLocation)
                        }
                        
                    } else {
                        findingLocation()
                    }
                    
                    ForEach(locations) { location in
                        WeatherView(viewModel: WeatherViewModel(location: location), weatherConditionID: $weatherConditionID,
                                    selection: $manager.userData.selectedTag)
                            .tabItem {
                                Text(location.name ?? "")
                            }
                            .tag(location.tag)
                    }
                    
                    SettingsView(
                        temperature: $settings.settings.temperature,
                        pressure: $settings.settings.pressure
                    )
                    .tabItem { Image(systemName: "gearshape") }
                    .tag("settings")
                }
                .ignoresSafeArea(.all, edges: .top)
                
                LogoDataProvider()
                    .ignoresSafeArea()
            }
            
        }
        .onChange(of: manager.userData) { userData in
            DataManager.shared.save(userData)
        }
        .onChange(of: settings.settings) { settings in
            DataManager.shared.save(settings)
        }
    }
    
}

extension StartTabView {
    
    private func findingLocation() -> some View {
        FindingLocationView(selection: $manager.userData.selectedTag,
                            nameCurrentLocation: $nameCurrentLocation,
                            weatherConditionID: $weatherConditionID,
                            isShowLocalWeather: $isShowLocalWeather)
            .tabItem {
                Label(nameCurrentLocation, systemImage: "location")
            }
            .tag(Constant.tagCurrentLocation.rawValue)
    }
    
    private func weather(currentLocation: Location) -> some View {
        WeatherView(viewModel: WeatherViewModel(location: currentLocation),
                    weatherConditionID: $weatherConditionID,
                    selection: $manager.userData.selectedTag)
            
            .tabItem {
                Label(nameCurrentLocation, systemImage: "location")
            }
            .tag(Constant.tagCurrentLocation.rawValue)
    }
    
    private var isShowSearchView: Bool {
        locations.count < 4
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
