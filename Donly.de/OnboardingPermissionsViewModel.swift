//
//  OnboardingPermissionsViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 5/13/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import UIKit

protocol OnboardingPermissionsProtocol {
  func locationRequested()
  func notificationsRequested()
}

protocol OnboardingPermissionsViewModelProtocol {
  var onboardingPermissionsPage: OnboardingPermissionsScene.OnboardingPermissionsPage { get }
  var onboardingInfoElement: OnboardingInfoElement { get }
  var onboardingPermissionsImageSet: OnboardingPermissionsScene.PermissionsImageSet { get }
  var onboardingPermissionsButtons: OnboardingPermissionsScene.PermissionsButtons { get }
  func acceptButtonPressed(delegate: OnboardingPermissionsVCProtocol)
  func cancelButtonPressed(delegate: OnboardingPermissionsVCProtocol)
}

class OnboardingPermissionsViewModel: OnboardingPermissionsViewModelProtocol {
  
  var onboardingPermissionsPage: OnboardingPermissionsScene.OnboardingPermissionsPage
  var onboardingInfoElement: OnboardingInfoElement
  var onboardingPermissionsImageSet: OnboardingPermissionsScene.PermissionsImageSet
  var onboardingPermissionsButtons: OnboardingPermissionsScene.PermissionsButtons
  var delegate: OnboardingPermissionsVCProtocol?
  
  init(withPage page: OnboardingPermissionsScene.OnboardingPermissionsPage) {
    self.onboardingPermissionsPage = page
    switch page {
    case .notifications:
      self.onboardingInfoElement = (title: "Bekanntmachung über die interessanten Aufgaben", description: "Lassen Sie Benachrichtigungen auf Ihrem Tefefon schnell über neue Angebote, um herauszufinden.")
      guard let center = UIImage(named: "notifications_icon_center"), let left = UIImage(named: "notifications_icon_left"), let right = UIImage(named: "notifications_icon_right") else {
        fatalError("Failed to load image set.")
      }
      self.onboardingPermissionsImageSet = (center: center, left: left, right: right)
      self.onboardingPermissionsButtons = (cancel: "Not now", accept: "Notify !Me")
    case .location:
      self.onboardingInfoElement = (title: "Schalten Sie geolocation", description: "Dies wird uns helfen, Arbeisplätze in Ihrer Nähe zu finden.")
      guard let center = UIImage(named: "location_icon_center"), let left = UIImage(named: "location_icon_left"), let right = UIImage(named: "location_icon_right") else {
        fatalError("Failed to load image set.")
      }
      self.onboardingPermissionsImageSet = (center: center, left: left, right: right)
      self.onboardingPermissionsButtons = (cancel: "Now now", accept: "Geolocation Me!")
    }
  }
  
}

extension OnboardingPermissionsViewModel: OnboardingPermissionsProtocol {
  
  func acceptButtonPressed(delegate: OnboardingPermissionsVCProtocol) {
    self.delegate = delegate
    switch onboardingPermissionsPage {
    case .notifications:
      requestNotifications()
    case .location:
      requestLocation()
    }
  }
  
  func cancelButtonPressed(delegate: OnboardingPermissionsVCProtocol) {
    self.delegate = delegate
    delegate.navigateTo(vc: getNextVC())
  }
  
  func requestLocation() {
    locationManager.requestWith(delegate: self)
  }
  
  func requestNotifications() {
    notificationsManager.requestWith(delegate: self)
  }
  
  func locationRequested() {
    delegate?.navigateTo(vc: getNextVC())
  }
  
  func notificationsRequested() {
    delegate?.navigateTo(vc: getNextVC())
  }
  
  func getNextVC() -> UIViewController {
    switch onboardingPermissionsPage {
    case .notifications:
      return OnboardingPermissionsScene.configure(forPage: .location)
    case .location:
      return OnboardingLoginScene.configure()
    }
  }
}
