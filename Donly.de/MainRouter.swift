//
//  MainRouter.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/10/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

protocol MainRouterProtocol {
  func routeToConversation(_ conversation: Conversation, withConvsVM convsVM: ConversationsViewModel)
  func routeToAllJobs()
}

class MainRouter: MainRouterProtocol {
  
  unowned var mainViewController: MainVC
  var viewModel: MainViewModelProtocol?
  
  init(withMainViewcontroller vc: MainVC, andViewModel viewModel: MainViewModelProtocol?) {
    self.mainViewController = vc
    self.viewModel = viewModel
  }
  
  func routeToConversation(_ conversation: Conversation, withConvsVM convsVM: ConversationsViewModel) {
    let vc = ConversationScene.configure(forConversation: conversation, withConvsVM: convsVM)
    DispatchQueue.main.async {
      self.mainViewController.navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  func routeToAllJobs() {
    self.viewModel?.page = .allTasks
    self.mainViewController.loadViewForContainer()
    self.mainViewController.updateBar(forNewPage: MainScene.MainPage.allTasks)
  }
  
  func routeToProfile() {
    self.viewModel?.page = .profile
    self.mainViewController.loadViewForContainer()
    self.mainViewController.updateBar(forNewPage: MainScene.MainPage.profile)
  }
  
}
