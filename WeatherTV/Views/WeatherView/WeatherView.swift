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
        VStack{
            
            HStack{
                Spacer()
                Text(viewModel.locationName)
                    .font(.largeTitle)
                Spacer()
                Button(action: {viewModel.fetchCurrentWeather()}) {
                    Image(systemName: "arrow.clockwise")
                }
//                    .font(.title2)
//                    .buttonStyle(CardButtonStyle())
            }
            
            HStack{
                Image(systemName: "sun.haze")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 300)
                
                Spacer()
                
                Text(viewModel.temp)
                    .font(.system(size: 120))
                    .bold()
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(viewModel.feelsLike)
                    Text(viewModel.humidity)
                    Text(viewModel.pressure)
                }.font(.body)
            }
            
            Spacer()
            
        }.onAppear(perform: viewModel.fetchCurrentWeather)
        
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
