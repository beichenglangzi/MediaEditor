//
//  BMWeatherDataManager.swift
//  Media Editor
//
//  Created by Baptiste on 12/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import CoreLocation

/// This class fetch and retrieve Geolocation coordinated then weather data from an api.
class BMWeatherDataManager: NSObject {
    
    static let _instance = BMWeatherDataManager()
    
    class var `default`: BMWeatherDataManager {
        return _instance
    }
    
    let locationManager = CLLocationManager()
    
    var onWeatherUpdate: ((BMWeatherInfos?) -> Void)?

    var lastLocationCoordinates: CLLocationCoordinate2D? {
        didSet {
            updateWeatherToCurrentLocation()
        }
    }
    
    var weatherForLastLocation: BMWeatherInfos? {
        didSet {
            DispatchQueue.global(qos: .default).async {
                DispatchQueue.main.async {
                    self.onWeatherUpdate?(self.weatherForLastLocation)
                }
            }
        }
    }

    func updateWeatherToCurrentLocation() {

        guard let loc = lastLocationCoordinates
            else { return }
        
        fetchWeather(for: loc, completion: { weather in
            self.weatherForLastLocation = weather
        })
    }

    func startUpdatingLocation() {
    
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func fetchWeather(for location: CLLocationCoordinate2D,
                      completion: @escaping (BMWeatherInfos?) -> Void) {
        
        let params = ["lat": location.latitude as AnyObject,
                      "lon": location.longitude as AnyObject]
        
        let request = BMRequest(route: .weatherInfos, parameters: params)
        request.responseHandler = { (request, response) in
                
            if response.code == 200,
                let json = response.value,
                let weatherInfos = BMWeatherInfos(json: json) {
                
                print("✅ Successfully fetched weather infos.")
                completion(weatherInfos)
            }
            else {
                print("❌ Error fetching weather infos.")
                completion(nil)
            }
        }
        request.send()

    }
}

extension BMWeatherDataManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let loc: CLLocationCoordinate2D = manager.location?.coordinate
            else { return }
        
        lastLocationCoordinates = loc
    }
}
