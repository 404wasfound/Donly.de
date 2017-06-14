//
//  SplashVCScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class SplashScene {
  
  enum Route {
    case onboarding
    case main
    case login
  }
  
  static func configure() -> SplashVC {
    let viewModel = SplashViewModel()
    return SplashVC(withViewModel: viewModel)
  }
  
}
