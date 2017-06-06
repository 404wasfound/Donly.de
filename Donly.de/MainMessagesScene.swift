//
//  MainMessagesScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/6/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class MainMessagesScene {
 
  static func configure() -> MainMessagesVC {
    let viewModel = MainMessagesViewModel()
    return MainMessagesVC(withViewModel: viewModel)
  }
  
}
