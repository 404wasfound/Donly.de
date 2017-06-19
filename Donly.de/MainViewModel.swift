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
    switch page {
    case .messages:
      let vc = ConversationsScene.configure(withMainRouter: router)
      scenesForPages[.messages] = vc
      return vc
    case .myTasks:
      let vc = JobsScene.configure(withMainRouter: router)
      scenesForPages[.myTasks] = vc
      return vc
    default: ()
    }
    return nil
  }
  
}
