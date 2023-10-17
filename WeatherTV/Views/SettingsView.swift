//
//  SettingsView.swift
//  WeatherTV
//
//  Created by Сергей on 31.03.2021.
//

import SwiftUI
import CoreLocation

struct SettingsView: View {
    @EnvironmentObject var manager: UserManager
    @Binding var temperature: TypeTemperature
    @Binding var pressure: TypePressure
    
    private let typeTemperature: [TypeTemperature] = [.c, .f]
    private let typePressure: [TypePressure] = [.hPa, .mmHg]
    
    private var animation: Animation {
        Animation.linear
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        
        if #available(tvOS 17.0, *) {
            NavigationView {
                ZStack {
                    HStack {
                        gearsView
                            .padding(.horizontal, 50)
                            .frame(width: UIScreen.main.bounds.width / 2.2)
                        Spacer()
                    }
                    listView
                        .safeAreaPadding(EdgeInsets(
                            top: 0,
                            leading: UIScreen.main.bounds.width / 2.2,
                            bottom: 0,
                            trailing: 0
                        ))
                }
            }
        } else {
            NavigationView {
                HStack {
                    gearsView
                        .padding(.horizontal, 50)
                    
                    listView
                        .frame(width: UIScreen.main.bounds.width / 2.2)
                }
            }
            .padding()
            .ignoresSafeArea(.all, edges: .horizontal)
        }
    }
}


extension SettingsView {
    
    @ViewBuilder var gearsView: some View {
        VStack {
            Text("Settings".localized())
                .font(.title2)
            GearsView()
                .offset(x: 0, y: -100)
            Spacer()
        }
    }
    
    @ViewBuilder var listView: some View {
        List {
            Picker("Temperature".localized(), selection: $temperature) {
                ForEach(typeTemperature, id: \.self) {
                    Text($0.rawValue.localized())
                }
            }
            .pickerStyle(InlinePickerStyle())
            
            Picker("Atmospheric pressure".localized(), selection: $pressure) {
                ForEach(typePressure, id: \.self) {
                    Text($0.rawValue.localized())
                }
            }
            .pickerStyle(InlinePickerStyle())
            
        }
        .listStyle(GroupedListStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(temperature: .constant(.c), pressure: .constant(.mmHg))
            .environmentObject(LocationManager.shared)
            .environmentObject(UserManager.shared)
            .environmentObject(SettingsManager.shared)
    }
}
