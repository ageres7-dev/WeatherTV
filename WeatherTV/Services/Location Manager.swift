//
//  Location Manager.swift
//  WeatherTV
//
//  Created by Сергей on 01.04.2021.
//
import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var location: CLLocation?
    @Published var status: CLAuthorizationStatus?
    
    
    static let shared = LocationManager()
    
    private let manager = CLLocationManager()
    
//    var complition: ((CLLocation) -> Void)?
    
    override private init() {
        super .init()
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.requestLocation()
    }
    
//    public func getLocation(complition: @escaping ((CLLocation) -> Void)) {
//        self.complition = complition
//        manager.requestWhenInUseAuthorization()
//        manager.delegate = self
////        manager.startUpdatingLocation()
//        manager.requestLocation()
//    }
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        self.status = status
//    }
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        status = manager.authorizationStatus
        
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location
        
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
