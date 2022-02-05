//
//  Location Manager.swift
//  WeatherTV
//
//  Created by Сергей on 01.04.2021.
//
import Foundation
import Combine
import CoreLocation
import MapKit


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var location: CLLocation? {
        didSet { objectWillChange.send() }
    }
    
    @Published var status: CLAuthorizationStatus? {
        didSet { objectWillChange.send() }
    }
    
    @Published var placemark: CLPlacemark? {
        didSet { objectWillChange.send() }
    }
    
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private let defaultLocale = Locale.init(identifier: "en_US")
    
    private let request = MKLocalSearch.Request()
    private var localSearch: MKLocalSearch?
    
    override private init() {
        super.init()
        manager.delegate = self
    }
    
    func findLocationMap(from string: String, completion: @escaping ([CLPlacemark]?) -> Void) {
        request.resultTypes = .address
        request.naturalLanguageQuery = string
        
        localSearch = MKLocalSearch(request: request)
        localSearch?.start { (searchResponse, _) in
            guard let items = searchResponse?.mapItems else { return }
            
            let placemarks = items.map {
                $0.placemark as CLPlacemark
            }
            completion(placemarks)
        }
    }
   
    func requestLocation() {
        manager.requestLocation()
    }
    
    func requestWhenInUseAuthorization() {
        manager.requestWhenInUseAuthorization()
    }

    func findLocation(from string: String, completion: @escaping ([CLPlacemark]?) -> Void) {
        geocoder.geocodeAddressString(string, in: nil, preferredLocale: defaultLocale) { placemarks, _ in
            completion(placemarks)
        }
    }
    
    private func geocode() {
        guard let location = self.location else { return }
    
        geocoder.reverseGeocodeLocation(location, preferredLocale: defaultLocale) { (places, error) in
            if error == nil {
                self.placemark = places?.first
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
