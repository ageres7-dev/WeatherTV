//
//  GearsView.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 04.07.2021.
//

import SwiftUI

struct GearsView: View {
    @State private var isRotated = false
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.height, geometry.size.width)
            let sizeBigGear = size / 2
            let sizeLittleGear = size / 3
            
            VStack(spacing: 0) {
                Image(systemName: "gearshape")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(Angle.degrees(isRotated ? 360 : 0))
                    .offset(x: -size * 0.145,
                            y: size * 0.07)
                    .frame(width: sizeBigGear, height: sizeBigGear)
                
                Image(systemName: "gearshape")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(Angle(degrees: 22))
                    .rotationEffect(Angle.degrees(isRotated ? -360 : 0))
                    .offset(x: size * 0.145,
                            y: -size * 0.07)
                    .frame(width: sizeLittleGear, height: sizeLittleGear)
            }
            .animation(
                Animation.linear(duration: 180)
                    .repeatForever(autoreverses: false)
            )
            .frame(width: geometry.size.width,
                   height: geometry.size.height,
                   alignment: .center)
            
            .onAppear{ isRotated = true }
            .onDisappear { isRotated = false }
        }
    }
}

struct GearsView_Previews: PreviewProvider {
    static var previews: some View {
        GearsView()
    }
}
