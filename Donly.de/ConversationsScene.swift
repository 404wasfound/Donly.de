//
//  ConversationsScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/6/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class ConversationsScene {
 
  static func configure() -> ConversationsVC {
    let viewModel = ConversationsViewModel()
    return ConversationsVC(withViewModel: viewModel)
  }
  
}