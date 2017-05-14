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
  var error: Variable<LoginError?> { get set }
  func attemptLogin()
}

typealias LoginButtons = (login: String, register: String)
typealias LoginError = (title: String, message: String)

class OnboardingLoginViewModel: OnboardingLoginViewModelProtocol {
  
  var loginButtons: LoginButtons
  var error = Variable<LoginError?>(nil)
  var loginInput: String?
  var passwordInput: String?
  var disposeBag = DisposeBag()
  
  init() {
    self.loginButtons = (login: "Einloggen", register: "Zu einem Darsteller")
  }
  
  func attemptLogin() {
    if checkInputFields() {
      print("Fire request!")
//      let userRequest = UserAPIRequest(parameters: [:])
//      _ = userRequest.requestData().asObservable().subscribe(onNext: { user in
//        /// assign the user oject to AppData
//      }, onError: { error in
//        self.error.value = (title: "Connection Error", message: "\(error.localizedDescription)")
//      }).addDisposableTo(disposeBag)
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
    self.error.value = (title: "Error", message: "Please, enter your account name")
    return false
  }
  
  func checkPasswordField() -> Bool {
    if let input = passwordInput, !input.isEmpty {
      return true
    }
    self.error.value = (title: "Error", message: "Please, enter your password")
    return false
  }
  
}
