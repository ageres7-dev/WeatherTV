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
    
    @Published var placemark: CLPlacemark? {
        willSet { objectWillChange.send() }
    }
    
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private let defaultLocale = Locale.init(identifier: "en_US")
    override private init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    
    func requestWhenInUseAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    private func geocode() {
        guard let location = self.location else { return }
    
        geocoder.reverseGeocodeLocation(location, preferredLocale: defaultLocale) { (places, error) in
            if error == nil {
                self.placemark = places?[0]
            } else {
                self.placemark = nil
            }
        }
    }
    
    func findLocation(from string: String, completion: @escaping ([CLPlacemark]?) -> Void) {
        
        geocoder.geocodeAddressString(string, in: nil, preferredLocale: defaultLocale) {  placemarks, _ in
            completion(placemarks)
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
