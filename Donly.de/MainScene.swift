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
    
    func getImageForSelectedState() -> UIImage? {
      switch self {
      case .messages:
        return UIImage(named: "menu_icon_messages_selected")
      case .myTasks:
        return UIImage(named: "menu_icon_mytasks_selected")
      case .allTasks:
        return UIImage(named: "menu_icon_alltasks_selected")
      case .notifications:
        return UIImage(named: "menu_icon_notifications_selected")
      case .profile:
        return UIImage(named: "menu_icon_profile_selected")
      }
    }
    
    func getImageForUnselectedState() -> UIImage? {
      switch self {
      case .messages:
        return UIImage(named: "menu_icon_messages")
      case .myTasks:
        return UIImage(named: "menu_icon_mytasks")
      case .allTasks:
        return UIImage(named: "menu_icon_alltasks")
      case .notifications:
        return UIImage(named: "menu_icon_notifications")
      case .profile:
        return UIImage(named: "menu_icon_profile")
      }
    }
    
    func getTitleForScreen() -> String {
      switch self {
      case .messages:
        return "Messages"
      case .myTasks:
        return "My Tasks"
      case .allTasks:
        return "All Tasks"
      case .notifications:
        return "Notifications"
      case .profile:
        return "Profile"
      }
    }
    
  }
  
  enum Route {
    case conversation
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
