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
import NVActivityIndicatorView

protocol OnboardingLoginVCProtocol {
  func showActivityIndicator()
  func hideActivityIndicator()
  func navigateTo(vc: UIViewController)
}

class OnboardingLoginVC: UIViewController {

//  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet private weak var loginTextfield: UITextField!
  @IBOutlet private weak var passwordTextfield: UITextField!
  @IBOutlet private weak var loginButton: OnboardingButton!
  @IBOutlet private weak var registerButton: OnboardingButton!
  
  internal var viewModel: OnboardingLoginViewModelProtocol?
  internal var disposeBag = DisposeBag()
//  internal var activityIndicator: NVActivityIndicatorView?
//  fileprivate var activeField: UITextField?

  init(withViewModel viewModel: OnboardingLoginViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: String(describing: OnboardingLoginVC.self), bundle: nil)
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
  
  override func viewWillAppear(_ animated: Bool) {
//    registerForKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
//    deregisterFromKeyboardNotifications()
  }
  
  func setupUI() {
    guard let model = viewModel else {
      fatalError("Failed to setup UI.")
    }
    self.loginButton.configure(button: .accept, title: model.loginButtons.login)
    self.registerButton.configure(button: .cancel, title: model.loginButtons.register)
  }
  
  func setupBindings() {
    self.loginTextfield.rx.text.bind(onNext: { login in
      self.viewModel?.loginInput = login
    }).addDisposableTo(disposeBag)
    
    self.passwordTextfield.rx.text.bind(onNext: { password in
      self.viewModel?.passwordInput = password
    }).addDisposableTo(disposeBag)
 
    viewModel?.error.asObservable().bind(onNext: { error in
      if let error = error {
        let alert = alertManager.createAlertWith(style: .notification, title: error.title, message: error.message)
        self.present(alert, animated: true, completion: nil)
      }
    }).addDisposableTo(disposeBag)
    
    self.loginButton.rx.tap.subscribe(onNext: {
      self.viewModel?.attemptLogin(delegate: self)
    }).addDisposableTo(disposeBag)
    
    self.registerButton.rx.tap.subscribe(onNext: {
      /// placeholder for now
      print("Register button is pressed!")
    }).addDisposableTo(disposeBag)
  }
  
}

extension OnboardingLoginVC: UITextFieldDelegate {
  
//  func textFieldDidBeginEditing(_ textField: UITextField) {
//    self.activeField = textField
//  }
// 
//  func textFieldDidEndEditing(_ textField: UITextField) {
//    self.activeField = nil
//  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
}

extension OnboardingLoginVC: OnboardingLoginVCProtocol {
  
  func showActivityIndicator() {
    ActivityIndicatorManager.shared.show(onView: self.view)
  }
  
  func hideActivityIndicator() {
    ActivityIndicatorManager.shared.hide()
  }
  
//  func triggerActivityIndicator() {
//    if let indicator = activityIndicator {
//      if indicator.isAnimating {
//        indicator.stopAnimating()
//        UIApplication.shared.endIgnoringInteractionEvents()
//      } else {
//        indicator.startAnimating()
//        UIApplication.shared.beginIgnoringInteractionEvents()
//      }
//    } else {
//      let frame = CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60.0, height: 60.0)
//      self.activityIndicator = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballScaleMultiple, color: donlyColor, padding: nil)
//      self.view.addSubview(self.activityIndicator!)
//      self.activityIndicator?.startAnimating()
//      UIApplication.shared.beginIgnoringInteractionEvents()
//    }
//  }
  
  func navigateTo(vc: UIViewController) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.rootViewController = vc
    appDelegate.window?.makeKeyAndVisible()
  }
  
}

extension OnboardingLoginVC {
  
//  func registerForKeyboardNotifications(){
//    //Adding notifies on keyboard appearing
//    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//  }
//  
//  func deregisterFromKeyboardNotifications(){
//    //Removing notifies on keyboard appearing
//    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//  }
//  
//  func keyboardWasShown(notification: NSNotification){
//    //Need to calculate keyboard exact size due to Apple suggestions
//    self.scrollView.isScrollEnabled = true
//    var info = notification.userInfo!
//    let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
//    let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
//    self.scrollView.contentInset = contentInsets
//    self.scrollView.scrollIndicatorInsets = contentInsets
//    var aRect : CGRect = self.view.frame
//    aRect.size.height -= keyboardSize!.height
//    if let activeField = self.activeField {
//      if (!aRect.contains(activeField.frame.origin)){
//        self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
//      }
//    }
//  }
//  
//  func keyboardWillBeHidden(notification: NSNotification){
//    //Once keyboard disappears, restore original positions
//    var info = notification.userInfo!
//    let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
//    let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
//    self.scrollView.contentInset = contentInsets
//    self.scrollView.scrollIndicatorInsets = contentInsets
//    self.view.endEditing(true)
//    self.scrollView.isScrollEnabled = false
//  }
}
