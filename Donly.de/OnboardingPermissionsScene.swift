//
//  OnboardingPermissionsScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import UIKit

class OnboardingPermissionsScene {
  
  enum OnboardingPermissionsPage {
    case notifications
    case location
  }
  
  enum PermissionsButton {
    case cancel
    case accept
  }
  
  typealias PermissionsImageSet = (center: UIImage, left: UIImage, right: UIImage)
  typealias PermissionsButtons = (cancel: String, accept: String)
  
  static func configure(forPage page: OnboardingPermissionsPage) -> OnboardingPermissionsVC {
    let viewModel = OnboardingPermissionsViewModel(withPage: page)
    return OnboardingPermissionsVC(withViewModel: viewModel)
  }
  
}
