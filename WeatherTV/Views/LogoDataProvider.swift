//
//  LogoDataProvider.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 30.05.2021.
//

import SwiftUI

struct LogoDataProvider: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                
                HStack(spacing: 0) {
                    VStack(alignment: .center) {
                        
                        Image(colorScheme == .dark ? "logo_white" : "logo_dark" )
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(0.8)
                            .frame(height: 60)
                            .shadow(radius: 30)
                        
                        Group {
                            Text("Data source provider")
                            Text("openweathermap.org")
                        }
                        .font(.system(size: 16))
                    }
                    .offset(x: -90, y: -30)
                    
                    Spacer()
                }
            }
            Spacer()
        }
    }
}

struct LogoDataProvider_Previews: PreviewProvider {
    static var previews: some View {
        LogoDataProvider()
    }
}
