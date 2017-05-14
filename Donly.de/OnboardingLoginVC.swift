//
//  OnboardingLoginVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 5/14/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit

class OnboardingLoginVC: UIViewController {

  @IBOutlet private weak var loginTextfield: UITextField!
  @IBOutlet private weak var passwordTextfield: UITextField!
  @IBOutlet private weak var loginButton: OnboardingButton!
  @IBAction private func loginButtonPressed(_ sender: UIButton) {
    /// login button pressed
  }
  @IBOutlet private weak var registerButton: OnboardingButton!
  @IBAction private func registerButtonPressed(_ sender: UIButton) {
    /// register button pressed
  }
  
  internal var viewModel: OnboardingLoginViewModelProtocol?

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
  
}

extension OnboardingLoginVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
}
