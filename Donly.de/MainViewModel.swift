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
  func configureViewForContainer(withRouter router: MainRouterProtocol) -> UIViewController?
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
  
  func configureViewForContainer(withRouter router: MainRouterProtocol) -> UIViewController? {
    if let vc = scenesForPages[page] {
      return vc
    }
    var vc: UIViewController?
    switch page {
    case .messages:
      vc = ConversationsScene.configure(withMainRouter: router)
    case .myTasks:
      vc = JobsScene.configure(withMainRouter: router, forPage: .myTasks)
    case .allTasks:
      vc = JobsScene.configure(withMainRouter: router, forPage: .allTasks)
    default: ()
    }
    scenesForPages[page] = vc
    return vc
  }
  
}
