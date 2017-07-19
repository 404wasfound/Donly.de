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
    let frame = CGRect(x: 0, y: 0, width: 60.0, height: 60.0)
    self.activityIndicator = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballScaleMultiple, color: donlyColor, padding: nil)
    self.activityIndicator?.center = view.center
    guard let indicator = self.activityIndicator else {
      return
    }
    view.addSubview(indicator)
    indicator.startAnimating()
    UIApplication.shared.beginIgnoringInteractionEvents()
  }
  
  func hide() {
    if let _ = self.activityIndicator {
      self.activityIndicator?.stopAnimating()
      UIApplication.shared.endIgnoringInteractionEvents()
      self.activityIndicator = nil
    }
  }
  
}
