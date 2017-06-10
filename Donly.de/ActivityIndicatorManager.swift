//
//  ActivityIndicatorManager.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/10/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class ActivityIndicatorManager {
  static let shared = ActivityIndicatorManager()
  
  internal var activityIndicator: NVActivityIndicatorView?
  
  func show(onView view: UIView) {
    let frame = CGRect(x: view.frame.width / 2 - 30, y: view.frame.height / 2 - 30, width: 60.0, height: 60.0)
    self.activityIndicator = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballScaleMultiple, color: donlyColor, padding: nil)
    guard let indicator = self.activityIndicator else {
      return
    }
    view.addSubview(indicator)
    indicator.startAnimating()
    UIApplication.shared.beginIgnoringInteractionEvents()
  }
  
  func hide() {
    self.activityIndicator?.stopAnimating()
    UIApplication.shared.endIgnoringInteractionEvents()
    self.activityIndicator = nil
  }
  
}
