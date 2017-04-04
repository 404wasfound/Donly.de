//
//  LocationManager.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/4/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import CoreLocation

var locationManager = LocationManager.shared

class LocationManager: NSObject, CLLocationManagerDelegate {
  
  static let shared = LocationManager()
  let locationManager = CLLocationManager()
  var delegate: OnboardingPermissionsProtocol?
  
  func requestWith(delegate: OnboardingPermissionsProtocol) {
    self.delegate = delegate
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedWhenInUse:
      locationManager.startUpdatingLocation()
      delegate?.locationRequested()
    case .denied:
      appData.setCurrent(location: nil)
      delegate?.locationRequested()
    default: ()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      let newLocation = Location(lon: location.coordinate.longitude, lat: location.coordinate.latitude)
      appData.setCurrent(location: newLocation)
    }
  }
  
}
