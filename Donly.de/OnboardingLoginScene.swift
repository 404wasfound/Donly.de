//
//  OnboardingLoginScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class OnboardingLoginScene {
  
  typealias LoginButtons = (login: String, register: String)
  typealias LoginError = (title: String, message: String)
  
  static func configure() -> OnboardingLoginVC {
    let viewModel = OnboardingLoginViewModel()
    return OnboardingLoginVC(withViewModel: viewModel)
  }
  
}
