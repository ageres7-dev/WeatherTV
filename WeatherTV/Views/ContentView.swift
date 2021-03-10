//
//  ContentView.swift
//  WeatherTV
//
//  Created by Сергей on 08.03.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .bottom) {
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "gearshape")
                    }
                    .font(.title2)
                    .buttonStyle(CardButtonStyle())
                    
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
                    Text("Оренбург")
                        .bold()
                    Text("Сейчас")
                    Text("-8º")
                  
                }
                .font(.title)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
