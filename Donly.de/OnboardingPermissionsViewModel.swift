//
//  OnboardingPermissionsViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 5/13/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import UIKit

enum OnboardingPermissionsPage {
  case notifications
  case location
}

enum PermissionsButton {
  case cancel
  case accept
}

typealias PermissionsImageSet = (center: UIImage, left: UIImage, right: UIImage)
typealias PermissionsButtons = (cancel: String, accept: String)

protocol OnboardingPermissionsViewModelProtocol {
  var onboardingPermissionsPage: OnboardingPermissionsPage { get }
  var onboardingInfoElement: OnboardingInfoElement { get }
  var onboardingPermissionsImageSet: PermissionsImageSet { get }
  var onboardingPermissionsButtons: PermissionsButtons { get }
}

class OnboardingPermissionsViewModel: OnboardingPermissionsViewModelProtocol {
  
  var onboardingPermissionsPage: OnboardingPermissionsPage
  var onboardingInfoElement: OnboardingInfoElement
  var onboardingPermissionsImageSet: PermissionsImageSet
  var onboardingPermissionsButtons: PermissionsButtons
  
  init(page: OnboardingPermissionsPage) {
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
