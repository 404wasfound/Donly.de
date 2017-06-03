//
//  MainScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import UIKit

class MainScene {
  
  enum MainPage {
    case messages
    case myTasks
    case allTasks
    case notifications
    case profile
  }
  
  static func configure(forPage page: MainPage) -> UIViewController? {
    let storyBoard = UIStoryboard(name: String(describing: MainVC.self), bundle: nil)
    if let navController = storyBoard.instantiateInitialViewController() as? UINavigationController {
      if let mainVC = navController.viewControllers.first as? MainVC {
        mainVC.loadViewModel(forPage: page)
        return navController
      }
    }
    return nil
  }
  
}
