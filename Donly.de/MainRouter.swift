//
//  MainRouter.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/10/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

protocol MainRouterProtocol {
  func routeToConversation(_ conversation: Conversation)
}

class MainRouter: MainRouterProtocol {
  
  unowned var mainViewController: MainVC
  
  init(withMainViewcontroller vc: MainVC) {
    self.mainViewController = vc
  }
  
  func routeToConversation(_ conversation: Conversation) {
    let vc = ConversationScene.configure(forConversation: conversation)
    DispatchQueue.main.async {
      self.mainViewController.navigationController?.pushViewController(vc, animated: true)
    }
  }
  
}
