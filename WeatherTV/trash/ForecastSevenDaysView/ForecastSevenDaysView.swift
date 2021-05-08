//
//  ForecastSevenDaysView.swift
//  WeatherTV
//
//  Created by Сергей on 14.03.2021.
//
/*
import SwiftUI

struct ForecastSevenDaysView: View {
    @StateObject var viewModel = ForecastSevenDaysViewModel()
    
    var body: some View {
        ScrollView([.horizontal]){
            LazyHStack {
                ForEach((viewModel.dailyForecasts), id: \.self) { day in
                    DayForecastView(viewModel: DayForecastViewModel(daily: day))
                }
            }.onAppear(perform: viewModel.fetchForecast)
        }
    }
    
}

struct ForecastSevenDaysView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastSevenDaysView()
    }
}
*/
