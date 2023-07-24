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
        
        NavigationView {
            HStack {
                VStack {
                    Text("Settings".localized())
                        .font(.title2)
                    GearsView()
                        .offset(x: 0, y: -80)
                    Spacer()
                }
                .padding(50)
                
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
                .frame(width: UIScreen.main.bounds.width / 2.2)
            }
        }
        .padding()
        .ignoresSafeArea(.all, edges: .horizontal)
    }
}


//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
