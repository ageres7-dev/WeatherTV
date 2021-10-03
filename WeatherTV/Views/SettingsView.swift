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
    
    let typeTemperature = [TypeTemperature.c, TypeTemperature.f]
    let typePressure = [TypePressure.hPa, TypePressure.mmHg]
    
    private var animation: Animation {
        Animation.linear
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        
        NavigationView {
            HStack {
                VStack {
                    Text("Settings")
                        .font(.title2)
                    GearsView()
                        .offset(x: 0, y: -80)
                    Spacer()
                }
                .padding(50)
                
                List {
                    
                    Picker("Temperature", selection: $temperature) {
                        ForEach(typeTemperature, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(InlinePickerStyle())
                    
                    Picker("Atmospheric pressure", selection: $pressure) {
                        ForEach(typePressure, id: \.self) {
                            Text($0.rawValue)
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
    
    
    func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        let mf = MeasurementFormatter()
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return mf.string(from: output)
    }
}


//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
