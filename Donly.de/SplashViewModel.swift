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
  var nextController: UIViewController? { get set }
}

final class SplashViewModel: SplashViewModelProtocol {
  var onboardingShown: Bool
  var nextController: UIViewController?
  init() {
    self.onboardingShown = appSet.onboardingShown
    self.nextController = configureNext()
  }
}

extension SplashViewModel {
  func configureNext() -> UIViewController? {
    self.onboardingShown = false /// TODO: Remove, its temporary
    if onboardingShown {
       return MainScene.configure(forPage: MainScene.MainPage.messages)
    } else {
      return OnboardingInfoScene.configure()
    }
  }
}
