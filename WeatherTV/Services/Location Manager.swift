//
//  Location Manager.swift
//  WeatherTV
//
//  Created by Сергей on 01.04.2021.
//
import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
    }
    
    @Published var status: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
    }
    
    
    static let shared = LocationManager()
    
    private let manager = CLLocationManager()
    
    func requestWhenInUseAuthorization() {
        manager.requestWhenInUseAuthorization()
        
    }
    
    override private init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    
    
    private let geocoder = CLGeocoder()
    
    // Rest of the class
    
    @Published var placemark: CLPlacemark? {
        willSet { objectWillChange.send() }
    }
    
    private func geocode() {
        guard let location = self.location else { return }
        let usLocale = Locale.init(identifier: "en_US")
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: usLocale) { (places, error) in
            if error == nil {
                self.placemark = places?[0]
            } else {
                self.placemark = nil
            }
        }
    }
    
    
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        status = manager.authorizationStatus
        
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location
        geocode()
        
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find location: \(error.localizedDescription)")
    }
}








/*
 import CoreLocation
 
 class LocationFetcher: NSObject, CLLocationManagerDelegate, ObservableObject {
 let manager = CLLocationManager()
 @Published var lastKnownLocation: CLLocationCoordinate2D?
 
 override init() {
 super.init()
 manager.delegate = self
 manager.desiredAccuracy = kCLLocationAccuracyBest
 }
 
 func start() {
 manager.requestWhenInUseAuthorization()
 //        manager.startUpdatingLocation()
 manager.requestLocation()
 
 }
 
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
 
 lastKnownLocation = locations.first?.coordinate
 }
 }
 */
