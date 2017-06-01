//
//  OnboardingInfoScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class OnboardingInfoScene {
  
  static func configure() -> OnboardingInfoVC {
    let viewModel = OnboardingInfoViewModel()
    return OnboardingInfoVC(withViewModel: viewModel)
  }
  
}
