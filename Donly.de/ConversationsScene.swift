//
//  ConversationsScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/6/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class ConversationsScene {
 
  static func configure(withMainRouter router: MainRouterProtocol, andMainVC main: MainVCProtocol) -> ConversationsVC {
    let viewModel = ConversationsViewModel(withMainRouter: router, andMainVC: main)
    return ConversationsVC(withViewModel: viewModel)
  }
  
}
