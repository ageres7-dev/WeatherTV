//
//  ForecastView.swift
//  WeatherTV
//
//  Created by Сергей on 11.03.2021.
//

import SwiftUI

struct ForecastView: View {
    @StateObject var viewModel = ForecastViewModel()
    var body: some View {
        if viewModel.isShowingForecast{
            HStack{
                ForEach(viewModel.dailyForecast, id: \.self) { forecast in
                    VStack{
                        Text(forecast.weather?.first?.description ?? "-")
                        Text("\(lround(forecast.main?.temp ?? 0))")
                        Text(forecast.dtTxt ?? "")
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
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
