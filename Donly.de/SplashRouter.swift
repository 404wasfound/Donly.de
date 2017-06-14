//
//  SplashRouter.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/10/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import UIKit

class SplashRouter {
  
  private var viewModel: SplashViewModelProtocol?
  
  init(withViewModel viewModel: SplashViewModelProtocol) {
    self.viewModel = viewModel
  }
  
  func route() {
    guard let next = viewModel?.nextPage.value else {
      return
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    switch next {
    case .main:
      let vc = MainScene.configure(forPage: MainScene.MainPage.messages)
      appDelegate.window?.rootViewController = vc
    case .onboarding:
      UserDefaults.standard.set(true, forKey: "OnboardingShown")
      let vc = OnboardingInfoScene.configure()
      let navController = UINavigationController()
      navController.viewControllers = [vc]
      appDelegate.window?.rootViewController = navController
    case .login:
      let vc = OnboardingLoginScene.configure()
      let navController = UINavigationController()
      navController.viewControllers = [vc]
      appDelegate.window?.rootViewController = navController
    }
    appDelegate.window?.makeKeyAndVisible()
  }
  
}
