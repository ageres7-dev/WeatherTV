//
//  WeatherBackground.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 24.05.2021.
//

import SwiftUI


struct WeatherBackground: View {
    let conditionID: Int?
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 93/255, green: 80/255, blue: 175/255),
                Color(red: 35/255, green: 42/255, blue: 117/255)
            ]),
            startPoint: .top,
            endPoint: .bottom)
            .opacity(isThunderstorm ? defaultOpacity : 0)
            
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 119/255, green: 124/255, blue: 129/255),
                Color(red: 189/255, green: 189/255, blue: 193/255)
                
            ]),
            startPoint: .top,
            endPoint: .bottom)
            .opacity(isDrizzle ? defaultOpacity : 0)
            
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 172/255, green: 194/255, blue: 204/255),
                Color(red: 83/255, green: 122/255, blue: 125/255)
            ]),
            startPoint: .top,
            endPoint: .bottom)
            .opacity(isRain ? defaultOpacity : 0)
            
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 243/255, green: 245/255, blue: 251/255),
                Color(red: 236/255, green: 238/255, blue: 248/255)
            ]),
            startPoint: .top,
            endPoint: .bottom)
            .opacity(isSnow ? defaultOpacity : 0)
            
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 217/255, green: 193/255, blue: 162/255),
                Color(red: 153/255, green: 128/255, blue: 94/255)
            ]),
            startPoint: .top,
            endPoint: .bottom)
            .opacity(isAtmosphere ? defaultOpacity : 0)
            
            LinearGradient(gradient: Gradient(colors: [
                .lightYellow,
                .lightGreen
            ]),
            startPoint: .top,
            endPoint: .bottom)
            
            .opacity(isClear ? defaultOpacity : 0)
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 208/255, green: 224/255, blue: 227/255),
                Color(red: 124/255, green: 184/255, blue: 243/255)
            ]),
            startPoint: .top,
            endPoint: .bottom)
            .opacity(isClouds ? defaultOpacity : 0)
            
        }
        .animation(.linear(duration:2).delay(0))
        .ignoresSafeArea()
        
    }
}


extension WeatherBackground {
 
    private var defaultOpacity: Double { 0.7 }
    
    private var isClouds: Bool {
        guard let conditionID = conditionID else { return false }
       return (801...804).contains(conditionID)
    }
    
    private var isThunderstorm: Bool {
        guard let conditionID = conditionID else { return false }
       return (200...232).contains(conditionID)
    }
    
    private var isDrizzle: Bool {
        guard let conditionID = conditionID else { return false }
       return (300...321).contains(conditionID)
    }
    
    private var isRain: Bool {
        guard let conditionID = conditionID else { return false }
       return (500...531).contains(conditionID)
    }
    
    private var isSnow: Bool {
        guard let conditionID = conditionID else { return false }
       return (600...621).contains(conditionID)
    }
    
    private var isAtmosphere: Bool {
        guard let conditionID = conditionID else { return false }
       return (700...781).contains(conditionID)
    }
    
    private var isClear: Bool {
        guard let conditionID = conditionID else { return false }
        return conditionID == 800
    }
}


//
//struct WeatherBackgroundView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherBackground(conditionID: 300, temperature: 0)
//    }
//}
