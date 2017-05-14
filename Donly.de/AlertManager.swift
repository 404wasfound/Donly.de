//
//  AlertManager.swift
//  Donly.de
//
//  Created by Bogdan Yur on 5/14/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import UIKit

var alertManager = AlertManager.shared

enum AlertStyle {
  case notification
}

class AlertManager {
  
  static let shared = AlertManager()
  
  func createAlertWith(style: AlertStyle, title: String, message: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    switch style {
    case .notification:
      let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alert.addAction(action)
    }
    return alert
  }
  
}
