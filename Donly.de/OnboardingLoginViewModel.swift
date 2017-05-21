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
  func attemptLogin(delegate: OnboardingLoginVCProtocol)
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
  
  func attemptLogin(delegate: OnboardingLoginVCProtocol) {
    if checkInputFields() {
      delegate.triggerActivityIndicator()
      guard let login = loginInput, let password = passwordInput else {
        return
      }
      let parameters = ["email": login, "password": password]
      print(parameters)
      let userRequest = UserAPIRequest(parameters: parameters)
      userRequest.send().subscribe(onNext: { result in
        switch result {
        case .success(let user):
          print("Data is here!")
        case .failure(let error):
          print("Fuck you, the data is wrong!")
        }
      }, onError: { error in
        ///
      }, onCompleted: {
        delegate.triggerActivityIndicator()
      }).addDisposableTo(disposeBag)
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
