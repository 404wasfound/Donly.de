//
//  UIViewController+Extensions.swift
//  Donly.de
//
//  Created by Bogdan Yur on 5/14/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  func hideKeyboardOnTapOutside() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
}