//
//  SplashViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SplashViewModelProtocol {
  var onboardingShown: Bool { get set }
  var nextController: UIViewController? { get set }
}

class SplashViewModel: SplashViewModelProtocol {
  var onboardingShown: Bool
  var nextController: UIViewController?
  init() {
    self.onboardingShown = ApplicationSettings.shared.onboardingShown
    self.nextController = configureNext()
  }
}

extension SplashViewModel {
  func configureNext() -> UIViewController? {
    var vc = UIViewController()
    self.onboardingShown = false
    if onboardingShown {
      let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
      vc = storyboard.instantiateInitialViewController()!
    } else {
      let storyboard = UIStoryboard(name: "OnboardingStoryboard", bundle: nil)
      vc = storyboard.instantiateInitialViewController()!
    }
    return vc
  }
}
