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
    @State private var isFirstOnAppear = true
    
    var body: some View {
        VStack {
            
            HStack {
//                Spacer()
//                Text(viewModel.nameLocationOpenWeather ?? "")
                Spacer()
                
                Button(action: { showingActionSheet.toggle() }) {
                    Image(systemName: "trash")
                }
                 
                .opacity(viewModel.isShowDeleteBotton ? 1 : 0)
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("Remove \(viewModel.location.name ?? "a city") from the list?"), buttons: [
                        .destructive(Text("Delete")) {
                            viewModel.deleteAction()
                        },
                        .cancel()
                    ])
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
            viewModel.onAppearAction()
        }
        
        .onAppear {
            guard isFirstOnAppear else { return }
            viewModel.onAppearAction()
            viewModel.startAutoUpdateWeather()
            isFirstOnAppear = false
//            print(".onAppear \(viewModel.nameLocationOpenWeather ?? "")")
//            viewModel.onAppearAction()
//
//            guard selection == viewModel.location.tag else {
//                print("\(viewModel.nameLocationOpenWeather ?? "") экран не виден, выходим из функции .onAppear ")
//                return
//            }
//            weatherConditionID = viewModel.conditionCode
            
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(location: .orenburg), weatherConditionID: .constant(200), selection: .constant("orenburg"))
            .environmentObject(LocationManager.shared)
    }
}
