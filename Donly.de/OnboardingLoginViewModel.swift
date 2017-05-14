//
//  OnboardingLoginViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 5/14/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol OnboardingLoginViewModelProtocol {
  var loginButtons: LoginButtons { get }
  var loginInput: String? { get set }
  var passwordInput: String? { get set }
  var errorMessage: Variable<String?> { get set }
  func attemptLogin()
}

typealias LoginButtons = (login: String, register: String)

class OnboardingLoginViewModel: OnboardingLoginViewModelProtocol {
  
  var loginButtons: LoginButtons
  var errorMessage = Variable<String?>(nil)
  var loginInput: String?
  var passwordInput: String?
  
  init() {
    self.loginButtons = (login: "Einloggen", register: "Zu einem Darsteller")
  }
  
  func attemptLogin() {
    if checkInputFields() {
      print("Fire request!")
    }
  }
  
  func checkInputFields() -> Bool {
    if checkLoginField(), checkPasswordField() {
      return true
    } else {
      return false
    }
  }
  
  func checkLoginField() -> Bool {
    if let input = loginInput, !input.isEmpty {
      return true
    }
    self.errorMessage.value = "Login check failed!"
    return false
  }
  
  func checkPasswordField() -> Bool {
    if let input = passwordInput, !input.isEmpty {
      return true
    }
    self.errorMessage.value = "Password check failed!"
    return false
  }
  
}
