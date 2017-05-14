//
//  OnboardingLoginViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 5/14/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

protocol OnboardingLoginViewModelProtocol {
  var loginButtons: LoginButtons { get }
}

typealias LoginButtons = (login: String, register: String)

class OnboardingLoginViewModel: OnboardingLoginViewModelProtocol {
  
  var loginButtons: LoginButtons
  
  init() {
    self.loginButtons = (login: "Einloggen", register: "Zu einem Darsteller")
  }
}
