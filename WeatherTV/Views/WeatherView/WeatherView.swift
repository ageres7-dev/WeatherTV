//
//  WeatherView.swift
//  WeatherTV
//
//  Created by Сергей on 08.03.2021.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    @State private var showingActionSheet = false
    @Binding var weatherConditionID: Int?
    @Binding var selection: String
    
    var body: some View {
        VStack {
            /*
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
                
                Button(action: {viewModel.actionUpdateButton() }) {
                    Image(systemName: "arrow.clockwise")
                    
                }
            }
            */
            
            HStack {
                Spacer()
                if viewModel.isShowDeleteBotton {
                    Button(action: { showingActionSheet.toggle() }) {
                        Image(systemName: "trash")
                    }
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(title: Text("Remove \(viewModel.location.name ?? "a city") from the list?"), buttons: [
                            .destructive(Text("Delete")) {
                                viewModel.deleteAction()
                            },
                            .cancel()
                        ])
                    }
                }
            }
            Spacer()
            
            HStack{
                VStack{
                    if let icon = viewModel.icon {
                        Image(systemName: icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 230, height: 230)
                        
                        Text(viewModel.description)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .frame(width: 340)
                    }
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
            .offset(x: 0, y: -60)
            .padding()
            
            Spacer()
            LazyHStack {
                ForEach((viewModel.forecastFromTomorrow), id: \.self) { day in
                    DayForecastView(viewModel: DayForecastViewModel(daily: day))
                }
            }
            .frame(height: 130)
            .offset(x: 0, y: -60)
        }
        
        .onReceive(viewModel.$conditionCode) { code in
            guard selection == viewModel.location.tag else { return }
            weatherConditionID = code
        }
        .onChange(of: selection) { selection in
            guard selection == viewModel.location.tag else { return }
            weatherConditionID = viewModel.conditionCode
            //                weatherConditionID = viewModel.weatherConditionID
            // нужно переделать,
            // необходимо включить ограничения на обновления
            // сейчас обновляется при каждом появлении экрана
            //                viewModel.fetchWeather()
            //                viewModel.startAutoUpdateWeather()
        }
        
        .onAppear {
            guard selection == viewModel.location.tag else { return }
            weatherConditionID = viewModel.conditionCode
            //                weatherConditionID = viewModel.weatherConditionID
            // нужно переделать,
            // необходимо включить ограничения на обновления
            // сейчас обновляется при каждом появлении экрана
            viewModel.fetchWeather()
            viewModel.startAutoUpdateWeather()
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(location: .orenburg), weatherConditionID: .constant(200), selection: .constant("orenburg"))
            .environmentObject(LocationManager.shared)
    }
}
