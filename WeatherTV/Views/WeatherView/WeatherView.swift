//
//  WeatherView.swift
//  WeatherTV
//
//  Created by Сергей on 08.03.2021.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var weatherConditionID: Int?
    
    var body: some View {
        ZStack {
            WeatherBackground(weatherConditionID: $weatherConditionID)
                
                    .ignoresSafeArea()
//                    .opacity(showBackground ? 1 : 0)
                    
            
        VStack {
            HStack(spacing: 8) {
                Text("")
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
                if let locationName = viewModel.locationName {
                Image(systemName: "location")
                    .font(.body)
                Text(locationName)
                    .font(.title3)
                }
                
                
                Spacer()
//                NavigationLink(destination: SettingsView()) {
//                    Image(systemName: "gearshape")
//                }
                
                Button("showOneColor") {
                    withAnimation(.easeInOut(duration:7).delay(0)) {
                        weatherConditionID = 800
                    }
                }
                
              
                Button(action: {
                    viewModel.actionUpdateButton()
                    
                    
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
            
            Spacer()
            
            HStack{
                VStack{
                    Image(systemName: viewModel.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 230, height: 230)
                    
                    Text(viewModel.description)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .frame(width: 340)
                }
                Spacer()
                
                if let temp = viewModel.temp {
                    VStack {
                        Text(temp)
                            .font(.system(size: 180))
                        Text(viewModel.todayForecasts)
                        Text(viewModel.todayDate)
                    }
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(viewModel.feelsLike)
                    Text(viewModel.humidity)
                    Text(viewModel.pressure)
                    Text("")
                    Divider()
                    if let sunriseTime = viewModel.sunriseTime {
                        Text(sunriseTime)
                    }
                    
                    if let sunsetTime = viewModel.sunsetTime {
                        Text(sunsetTime)
                    }
                }
                .frame(width: 340)
                .font(.body)
                
            }
            .padding()
            
            Spacer()
            LazyHStack {
                ForEach((viewModel.forecastFromTomorrow), id: \.self) { day in
                    DayForecastView(viewModel: DayForecastViewModel(daily: day))
                }
            }
            .frame(height: 130)
            .offset(x: 0, y: -60)
            //            Spacer()
        }
        .onAppear {
            viewModel.fetchWeather()
            viewModel.startAutoUpdateWeather()
        }
        }
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .environmentObject(LocationManager.shared)
    }
}


struct WeatherBackground: View {
    @State private var thunderstorm = false //id 200-232
    @State private var drizzle = false //300-321
    @State private var rain = false // id 500-531
    @State private var snow = false // 600-621
    @State private var atmosphere = false //700-781
    @State private var clear = false // 800
    @State private var clouds = false // 801-804
    
    
    @Binding var weatherConditionID: Int?
    

    
    var body: some View {
        
//        let bindingEnteredValue = Binding(
//            get: { String(lround(self.sliderValue)) },
//            set: { self.enteredValue = $0 }
//        )
//        let bindingWeatherConditionID = Binding(
//            get: { weatherConditionID },
//            set: { }
//        )
        

        
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.lightBlue,
                                                       .lightGreen,
                                                       .lightYellow]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .opacity(thunderstorm ? 1 : 0)
            
            
            LinearGradient(gradient: Gradient(colors: [.red,
                                                       .yellow,
                                                       .blue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .opacity(drizzle ? 0.9 : 0)
            
            LinearGradient(gradient: Gradient(colors: [.lightBlue,
                                                       .lightGreen,
                                                       .lightYellow]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .opacity(rain ? 0.9 : 0)
            
            LinearGradient(gradient: Gradient(colors: [.blue,
                                                       .lightGreen,
                                                       .lightBlue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .opacity(snow ? 0.9 : 0)
            
            LinearGradient(gradient: Gradient(colors: [.gray,
                                                       .yellow,
                                                       .red]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .opacity(atmosphere ? 0.9 : 0)
            
            LinearGradient(gradient: Gradient(colors: [.red,
                                                       .lightGreen,
                                                       .lightYellow]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .opacity(clear ? 0.9 : 0)
            
            LinearGradient(gradient: Gradient(colors: [.black,
                                                       .lightGreen,
                                                       .lightYellow]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .opacity(clouds ? 0.9 : 0)
            
        }
        .onChange(of: weatherConditionID) { _ in
            changeColor()
            print("ddsdsd")
        }
        .ignoresSafeArea()
        .onAppear {
            changeColor()
        }
    }
}

extension WeatherBackground {
    func changeColor() {
        withAnimation(.easeInOut(duration:7).delay(1)) {
            guard let conditionID = weatherConditionID else { return }
            switch conditionID {
            case 200...232:
                thunderstorm = true
            case 300...321:
                drizzle = true
            case 500...531:
                rain = true
            case 600...621:
                snow = true
            case 700...781:
                atmosphere = true
            case 800:
                clear = true
            case 801...804:
                clouds = true
            default:
                return
            }
        }
    }
}

/*
 @State private var thunderstorm = false //id 200-232
 @State private var drizzle = false //300-321
 @State private var rain = false // id 500-531
 @State private var snow = false // 600-621
 @State private var atmosphere = false //700-781
 @State private var clear = false // 800
 @State private var clouds = false // 801-804
 
 */
