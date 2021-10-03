//
//  DayForecastView.swift
//  WeatherTV
//
//  Created by Сергей on 15.03.2021.
//

import SwiftUI

struct DayForecastView: View {
    let viewModel: DayForecastViewModel
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
            if let iconName = viewModel.iconName {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            Text(viewModel.temp)
            Text(viewModel.date)
                .font(.caption)
        }
        .multilineTextAlignment(.center)
        .frame(width: 160)
        .padding()
    }
}

//struct DailyForecastView_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyForecastView()
//    }
//}
