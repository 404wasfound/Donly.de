//
//  MainViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewModelProtocol {
  func configureViewForContainer(withRouter router: MainRouterProtocol, andMainVC main: MainVCProtocol) -> UIViewController?
  var page: MainScene.MainPage { get set }
  var currentScreen: UIViewController? { get set }
}

class MainViewModel: MainViewModelProtocol {
 
  var page: MainScene.MainPage
  var currentScreen: UIViewController?
  private var scenesForPages: [MainScene.MainPage: UIViewController?] = [:]
  
  init(withPage page: MainScene.MainPage) {
    self.page = page
  }
  
  func configureViewForContainer(withRouter router: MainRouterProtocol, andMainVC main: MainVCProtocol) -> UIViewController? {
    if let vc = scenesForPages[page] {
      return vc
    }
    var vc: UIViewController?
    switch page {
    case .messages:
      vc = ConversationsScene.configure(withMainRouter: router, andMainVC: main)
    case .myTasks:
      vc = JobsScene.configure(withMainRouter: router, andMainVC: main, forPage: .myTasks)
    case .allTasks:
      vc = JobsScene.configure(withMainRouter: router, andMainVC: main, forPage: .allTasks)
    case .profile:
      vc = ProfileScene.configure(withMainRouter: router)
    case .notifications:
      vc = NotificationsScene.configure(withMainRouter: router, andMainVC: main)
    }
    scenesForPages[page] = vc
    return vc
  }
  
}
