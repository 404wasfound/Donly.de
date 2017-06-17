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
  var loginButtons: OnboardingLoginScene.LoginButtons { get }
  var loginInput: String? { get set }
  var passwordInput: String? { get set }
  var error: Variable<OnboardingLoginScene.LoginError?> { get set }
  var delegate: OnboardingLoginVCProtocol? { get set }
  func attemptLogin()
}

class OnboardingLoginViewModel: OnboardingLoginViewModelProtocol {
  
  var loginButtons: OnboardingLoginScene.LoginButtons
  var error = Variable<OnboardingLoginScene.LoginError?>(nil)
  var loginInput: String?
  var passwordInput: String?
  var disposeBag = DisposeBag()
  var delegate: OnboardingLoginVCProtocol?
  
  init() {
    self.loginButtons = (login: "Einloggen", register: "Zu einem Darsteller")
  }
  
  func attemptLogin() {
    if checkInputFields() {
      delegate?.showIndicator()
      guard let login = loginInput, let password = passwordInput else {
        return
      }
      let parameters = ["email": login, "password": password]
      print(parameters)
      let userRequest = UserLoginAPIRequest(parameters: parameters)
      userRequest.send().subscribe(onNext: { result in
        if let error = result.error {
          print("Fuck you, the data is wrong!")
        } else if let user = result.result {
          print("Data is here!")
          appData.user = user
          guard let vc = MainScene.configure(forPage: MainScene.MainPage.messages) else {
            print("There is something very wrong with initializing of the VC!")
            return
          }
          self.delegate?.navigateTo(vc: vc)
        }
      }, onError: { error in
        /// Some errr handling at some point
      }, onCompleted: {
        self.delegate?.hideIndicator()
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
