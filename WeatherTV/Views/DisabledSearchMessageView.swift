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
            Text("The maximum number of cities has been reached.")
                .font(.title2)
            Text("Please remove one of the cities to add a new one.")
                .font(.title3)
            /*
             LazyHStack {
             ForEach(citiesForRemove) { city in
             
             Button {
             self.manager.userData.locations.removeAll(where: {
             $0.id == city.id
             })
             } label: {
             VStack {
             Image(systemName: "trash")
             .font(.title2)
             .foregroundColor(.red)
             .padding(.top)
             .padding(.bottom)
             
             
             Text("\(city.name ?? "")")
             }
             .frame(width: UIScreen.main.bounds.size.width / 7)
             .padding()
             }
             .buttonStyle(CardButtonStyle())
             }
             }
             .padding()
             */
        }
    }
}

extension DisabledSearchMessageView {
    var citiesForRemove: [Location] {
        manager.userData.locations.filter({ $0.tag != Constant.tagCurrentLocation.rawValue })
    }
}


struct DisabledSearchMessageView_Previews: PreviewProvider {
    static var previews: some View {
        DisabledSearchMessageView()
            .environmentObject(LocationManager.shared)
    }
}
