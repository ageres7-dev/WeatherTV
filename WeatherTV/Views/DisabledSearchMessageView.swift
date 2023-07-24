//
//  DisabledSearchMessageView.swift
//  WeatherTV
//
//  Created by Sergey Dolgikh on 23.06.2021.
//

import SwiftUI

struct DisabledSearchMessageView: View {
    @EnvironmentObject var manager: UserManager
    
    var body: some View {
        VStack {
            Image(systemName: "cloud.sun.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 450, height: 450)
                
            Text("The maximum number has been reached".localized())
                .font(.title2)
            Text("Please remove one of the cities to add a new one".localized())
                .font(.title3)
        }
    }
}

extension DisabledSearchMessageView {
    var citiesForRemove: [Location] {
        manager.userData.locations.filter { $0.tag != Constant.tagCurrentLocation.rawValue }
    }
}

struct DisabledSearchMessageView_Previews: PreviewProvider {
    static var previews: some View {
        DisabledSearchMessageView()
            .environmentObject(LocationManager.shared)
    }
}
