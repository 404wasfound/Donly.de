//
//  SplashViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import UIKit

protocol SplashViewModelProtocol {
  var onboardingShown: Bool { get set }
  var nextPage: SplashScene.Route? { get set }
}

final class SplashViewModel: SplashViewModelProtocol {
  var onboardingShown: Bool
  var nextPage: SplashScene.Route?
  init() {
    self.onboardingShown = appSet.onboardingShown
    self.nextPage = configureNext()
  }
}

extension SplashViewModel {
  func configureNext() -> SplashScene.Route? {
    self.onboardingShown = false /// TODO: Remove, its temporary
    if onboardingShown {
      return SplashScene.Route.main
    } else {
      return SplashScene.Route.onboarding
    }
  }
}
