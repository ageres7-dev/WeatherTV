//
//  StartTabView.swift
//  WeatherTV
//
//  Created by Сергей on 14.03.2021.
//

import SwiftUI

struct StartTabView: View {
   
    
    var body: some View {
        
        ZStack {
            NavigationView {
                FindingLocationView()
                
                
                //                TabView {
                //                    WeatherView()
                //                .tabItem { Image(systemName: "Weather") }
                
                //                    SettingsView()
                //                        .tabItem {
                //                            Label("Settings", systemImage: "gearshape")
                //                        }
                //
                //
                //                    SearchView()
                //                        .tabItem { Image(systemName: "magnifyingglass") }
                
                //                }
            }
            
            LogoDataProvider()
        }
    }
}

//        .tabViewStyle(PageTabViewStyle())


struct StartTabView_Previews: PreviewProvider {
    static var previews: some View {
        StartTabView()
            .environmentObject(LocationManager.shared)
    }
}


struct LogoDataProvider: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                
                HStack(spacing: 0) {
                    VStack(alignment: .center) {
                        
                        Image(colorScheme == .dark ? "logo_white" : "logo_dark" )
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(0.8)
                            .frame(height: 60)
                            .shadow(radius: 30)
                        
                        Group {
                            Text("Data source provider")
                            Text("openweathermap.org")
                        }
                        .font(.system(size: 16))
                    }
                    .offset(x: -90, y: 0)
                    
                    Spacer()
                }
            }
            Spacer()
        }
    }
}
