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
  func buttonTapped()
}

protocol OnboardingPermissionsProtocol {
  func locationRequested()
  func notificationsRequested()
}

class OnboardingViewModel: OnboardingViewModelProtocol {
  var text: Variable<String>
  var page: Variable<Page>
  var delegate: OnboardingPageProtocol?
  
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
    }
    self.delegate = delegate
    self.page = Variable(page)
  }
}

extension OnboardingViewModel: OnboardingPermissionsProtocol {
  
  func buttonTapped() {
    switch page.value {
    case .second:
      requestLocation()
    case .third:
      requestNotifications()
    case .fourth:
      segueToMainBoard()
    default: ()
    }
  }
  
  func requestLocation() {
    locationManager.requestWith(delegate: self)
  }
  
  func requestNotifications() {
    notificationsManager.requestWith(delegate: self)
  }
  
  func locationRequested() {
    delegate?.scrollTo(page: .third)
  }
  
  func notificationsRequested() {
    delegate?.scrollTo(page: .fourth)
  }
  
  func segueToMainBoard() {
    delegate?.performSegueToMainBoard()
  }
  
}
