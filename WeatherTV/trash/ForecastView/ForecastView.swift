//
//  ForecastView.swift
//  WeatherTV
//
//  Created by Сергей on 11.03.2021.
//
/*
import SwiftUI

struct ForecastView: View {
    @StateObject var viewModel = ForecastViewModel()
    var body: some View {
        ScrollView([.horizontal]){
            LazyHStack{
                
                if  let _ = viewModel.forecast?.list {
                    ForEach((viewModel.forecast?.list!)!, id: \.self) { forecast in
                        //                        Text(forecast.weather?.first?.description ?? "-")
//                                                Text("\(lround(forecast.main?.temp ?? 0))")
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            VStack{
                                Image(systemName: DataManager.shared.convert(iconName: forecast.weather?.first?.icon ?? "arrow.clockwise"))
                                Text(forecast.dtTxt ?? "---")
                                Text(forecast.weather?.first?.description ?? "---")
                            
                            }.padding()
                        }.buttonStyle(CardButtonStyle())
                    }
                }
                
                //            Text("\(viewModel.forecast?.cod ?? "-")")
                //            Text("\(viewModel.forecast?.cnt ?? 0)")
                //            Text("\(viewModel.forecast?.list?.count ?? 0)")
                //
                //            Text("\(viewModel.forecast?.list?.first?.dtTxt ?? "-")")
                //            Text("\(viewModel.forecast?.list?[1].dtTxt ?? "-")")
                //            Text("\(viewModel.forecast?.list?[39].dtTxt ?? "-")")
            
        }
            .onAppear(perform: viewModel.fetchForecast)
        }
        
    }
    
    
    private func convert(iconName:String) -> String {
        var result = ""
        
        switch iconName {
        case "01d": result = "sun.max"
        case "01n": result = "moon"
        case "02d": result = "cloud.sun"
        case "02n": result = "cloud.moon"
        case "03d": result = "cloud"
        case "03n": result = "cloud"
        case "04d": result = "smoke"
        case "04n": result = "smoke"
        case "09d": result = "cloud.rain"
        case "09n": result = "cloud.rain"
        case "10d": result = "cloud.sun.rain"
        case "10n": result = "cloud.moon.rain"
        case "11d": result = "cloud.bolt.rain"
        case "11n": result = "cloud.bolt.rain"
        case "13d": result = "snow"
        case "13n": result = "snow"
        case "50d": result = "smoke"
        case "50n": result = "smoke"
        default: result = "thermometer"
        }
        
        return result
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}


*/
