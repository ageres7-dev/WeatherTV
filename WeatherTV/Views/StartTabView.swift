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
            TabView{
                WeatherView()
                //                .tabItem { Image(systemName: "Weather") }
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                
                
                VStack{
                    Text("Search")
                }
                .tabItem { Image(systemName: "magnifyingglass") }
                
            }
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Spacer()
                    
                    HStack(spacing: 0){
                        Image("logo_white_cropped")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(0.8)
                            .frame(height: 60)
                            .offset(x: -90, y: 0)
                        
                        Spacer()
                    }
                }
                Spacer()
            }
        }
    }
}

//        .tabViewStyle(PageTabViewStyle())


struct StartTabView_Previews: PreviewProvider {
    static var previews: some View {
        StartTabView()
    }
}
