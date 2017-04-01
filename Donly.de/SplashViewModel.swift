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
    self.nextController = configureNext(shown: onboardingShown)
  }
}

extension SplashViewModel {
  func configureNext(shown: Bool) -> UIViewController? {
    var vc = UIViewController()
    if shown {
      let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
      vc = storyboard.instantiateInitialViewController()!
    } else {
      let storyboard = UIStoryboard(name: "OnboardingStoryboard", bundle: nil)
      vc = storyboard.instantiateInitialViewController()!
    }
    return vc
  }
}
