//
//  Location Manager.swift
//  WeatherTV
//
//  Created by Сергей on 17.03.2021.
//



import Foundation
import CoreLocation
import Combine
/*
class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var status: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
    }
    
    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
    }
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
//            self.locationManager.startUpdatingLocation()
        self.locationManager.requestLocation()
    }
    
    
    
    
    private let geocoder = CLGeocoder()
    
    // Rest of the class
    
    @Published var placemark: CLPlacemark? {
        willSet { objectWillChange.send() }
    }
    
    private func geocode() {
        guard let location = self.location else { return }
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
            if error == nil {
                self.placemark = places?[0]
            } else {
                self.placemark = nil
            }
        })
    }
    
    
}



extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.geocode()
    }
}



extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }
    
    var longitude: Double {
        return self.coordinate.longitude
    }
}

*/
