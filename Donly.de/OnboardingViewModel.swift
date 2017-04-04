//
//  OnboardingViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 3/30/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift

enum Page: String {
  case first = "first"
  case second = "second"
  case third = "third"
  case fourth = "fourth"
}

protocol OnboardingViewModelProtocol {
  var text: Variable<String> { get set }
  var page: Variable<Page> { get set }
  var delegate: OnboardingPageProtocol? { get set }
  func requestLocation()
  func requestNotifications()
}

extension OnboardingViewModelProtocol {
  func segueToMainBoard() {
    delegate?.performSegueToMainBoard()
  }
}

class OnboardingViewModel: NSObject, OnboardingViewModelProtocol {
  var text: Variable<String>
  var page: Variable<Page>
  var delegate: OnboardingPageProtocol?
  var locationManager = CLLocationManager()
  
  init(page: Page, delegate: OnboardingPageProtocol) {
    switch page {
    case .first:
      self.text = Variable("The first onboarding page about how good is the service, why to use it, what benefits to the user and all that stuff")
    case .second:
      self.text = Variable("The second onboarding page where we ask for location permissions with the button")
    case .third:
      self.text = Variable("The third onboarding page where we ask for push notifications permissions with the button")
    case .fourth:
      self.text = Variable("Go to main Screen")
      self.delegate = delegate
    }
    self.page = Variable(page)
  }
}

import CoreLocation

extension OnboardingViewModel: CLLocationManagerDelegate {
  
  func requestLocation() {
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
      locationManager.startUpdatingLocation()
    } else if status == .denied {
      appData.userLocation = Variable(nil)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      let coordinates = Location(lon: location.coordinate.longitude, lat: location.coordinate.latitude)
      appData.userLocation = Variable(coordinates)
      print("COORDINATES: \(appData.userLocation.value)")
    }
  }
  
}

extension OnboardingViewModel {
  func requestNotifications() {
    //something
  }
}
