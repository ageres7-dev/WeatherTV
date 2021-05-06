//
//  WeatherView.swift
//  WeatherTV
//
//  Created by Сергей on 08.03.2021.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        
        VStack {
            HStack{
                Spacer()
                Text(viewModel.locationName)
                    .font(.largeTitle)
                
                Spacer()
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape")
                }
                
                
                Button(action: {viewModel.fechWeather()}) {
                    Image(systemName: "arrow.clockwise")
                }
            }
            
            Spacer()
            
            HStack{
                VStack{
                    Image(systemName: viewModel.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 240, height: 240)
                    
                    Text(viewModel.discription)
                        .font(.title3)
                        .frame(width: 340)
                }
                Spacer()
                
                if let temp = viewModel.temp {
                    VStack {
                        Text(temp)
                            .font(.system(size: 160))
                        Text(viewModel.todayForecasts)
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
                }
                .frame(width: 340)
                .font(.body)
                
            }
            .padding()
            
            Spacer()
            LazyHStack {
                ForEach((viewModel.dailyForecasts), id: \.self) { day in
                    DayForecastView(viewModel: DayForecastViewModel(daily: day))
                }
            }
            .frame(height: 130)
        }
        .onAppear {
            viewModel.fechWeather()
            viewModel.startAutoUpdateWeather()
//            viewModel.timer
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
