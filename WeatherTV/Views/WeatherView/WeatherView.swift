//
//  WeatherView.swift
//  WeatherTV
//
//  Created by Сергей on 08.03.2021.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @EnvironmentObject var location: LocationManager
    
    //    var status: String    { return("\(String(location.status ?? ""))") }
    
    var body: some View {
        
        VStack{
            
            if let status = location.status {
                if status == .denied {
                    Text("Please allow access to the location")
                }
                
            }
            
            
            if let currentLocation = location.location {
                
                Text("\(currentLocation.coordinate.latitude)")
                    .onAppear(perform: {
                        
                        viewModel.latitude = String(currentLocation.coordinate.latitude)
                        print(currentLocation.coordinate.latitude)
                        viewModel.longitude = String(currentLocation.coordinate.longitude)
                        viewModel.fechWeather()
                    })
            }
            
            if location.location == nil {
                Text("Finding a location")
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            HStack{
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
                        .frame(width: 240)
                }
                Spacer()
                
                Text(viewModel.temp)
                    .font(.system(size: 160))
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(viewModel.feelsLike)
                    Text(viewModel.humidity)
                    Text(viewModel.pressure)
                }.font(.body)
                
            }
            .padding()
            
            Spacer()
            LazyHStack {
                ForEach((viewModel.dailyForecasts), id: \.self) { day in
                    DayForecastView(viewModel: DayForecastViewModel(daily: day))
                }
            }
            .frame(height: 130)
            //                .onAppear(perform: viewModel.fetchForecast)
            
            //                ForecastSevenDaysView()
            
        }
        //            .onAppear(perform: viewModel.fechWeather)
        
        
        .tabItem {
            Text(viewModel.locationName)
        }
        
        
        
        
        
    }
    /*
     ZStack {
     VStack {
     HStack(alignment: .bottom) {
     Spacer()
     Button(action: {viewModel.fetchCurrentWeather()}) {
     Image(systemName: "arrow.clockwise")
     }
     //                    .font(.title2)
     //                    .buttonStyle(CardButtonStyle())
     
     }
     Spacer()
     }
     
     
     HStack {
     Spacer()
     Image(systemName: "sun.haze")
     .resizable()
     .aspectRatio(contentMode: .fill)
     .frame(width: 400, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
     
     Spacer()
     
     VStack {
     Text("\(viewModel.currenWeather?.name ?? "")")
     .bold()
     Text("\(viewModel.currenWeather?.weather?.first?.main ?? "")")
     Text("\(viewModel.currenWeather?.weather?.first?.description ?? "")")
     //                    Text("\(viewModel.currenWeather?.rain?.oneHours)")
     Text("\( lround(viewModel.currenWeather?.main?.temp ?? 0) )º")
     
     }
     .font(.title)
     Spacer()
     }
     
     .onAppear(perform: viewModel.fetchCurrentWeather)
     }
     }
     */
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
