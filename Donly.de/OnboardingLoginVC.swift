//
//  OnboardingLoginVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 5/14/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OnboardingLoginVC: UIViewController {

  @IBOutlet private weak var loginTextfield: UITextField!
  @IBOutlet private weak var passwordTextfield: UITextField!
  @IBOutlet private weak var loginButton: OnboardingButton!
  @IBOutlet private weak var registerButton: OnboardingButton!
  
  internal var viewModel: OnboardingLoginViewModelProtocol?
  internal var disposeBag = DisposeBag()

  init(viewModel: OnboardingLoginViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: String(describing: OnboardingLoginVC.self), bundle: nil)
  }
  
  convenience init() {
    let viewModel = OnboardingLoginViewModel()
    self.init(viewModel: viewModel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardOnTapOutside()
    self.setupUI()
    self.setupBindings()
    self.loginTextfield.delegate = self
    self.passwordTextfield.delegate = self
  }
  
  func setupUI() {
    guard let model = viewModel else {
      fatalError("Failed to setup UI.")
    }
    self.loginButton.configure(button: .accept, title: model.loginButtons.login)
    self.registerButton.configure(button: .cancel, title: model.loginButtons.register)
  }
  
  func setupBindings() {
    self.loginTextfield.rx.text.bindNext({ login in
      self.viewModel?.loginInput = login
    }).addDisposableTo(disposeBag)
    
    self.passwordTextfield.rx.text.bindNext({ password in
      self.viewModel?.passwordInput = password
    }).addDisposableTo(disposeBag)
 
    viewModel?.errorMessage.asObservable().bindNext({ errorMessage in
      if let message = errorMessage {
        /// the call for the alert manager or smth
        print(message)
      }
    }).addDisposableTo(disposeBag)
    
    self.loginButton.rx.tap.subscribe(onNext: {
      self.viewModel?.attemptLogin()
    }).addDisposableTo(disposeBag)
    
    self.registerButton.rx.tap.subscribe(onNext: {
      /// placeholder for now
      print("Register button is pressed!")
    }).addDisposableTo(disposeBag)
  }
  
}

extension OnboardingLoginVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
}
