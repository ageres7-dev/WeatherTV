//
//  WeatherView.swift
//  WeatherTV
//
//  Created by Сергей on 08.03.2021.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    @Binding var weatherConditionID: Int?
    @Binding var selection: String
    @State private var showingActionSheet = false
    @State private var isFirstOnAppear = true
    
    var body: some View {
        VStack {
            
            HStack {
                
                Spacer()
                
                Button(action: { showingActionSheet.toggle() }) {
                    Image(systemName: "trash")
                }
                .opacity(viewModel.isShowDeleteBotton ? 1 : 0)
                .actionSheet(isPresented: $showingActionSheet) {
                    let city = viewModel.location.name ?? "a city".localized()
                    let deleteTitle = String(format: "Remove city from the list?".localized(), city)
                    
                    return ActionSheet(
                        title: Text(deleteTitle),
                        buttons: [
                            .destructive(Text("Delete".localized()), action: viewModel.deleteAction),
                            .cancel()
                        ]
                    )
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
                if let _ = viewModel.temp {
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
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(location: .orenburg), weatherConditionID: .constant(200), selection: .constant("orenburg"))
            .environmentObject(LocationManager.shared)
    }
}
