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
  func configureViewForContainer() -> UIViewController?
}

class MainViewModel: MainViewModelProtocol {
 
  var page: MainScene.MainPage
  
  init(withPage page: MainScene.MainPage) {
    self.page = page
  }
  
  func configureViewForContainer() -> UIViewController? {
    switch page {
    case .messages:
      return MainMessagesScene.configure()
    default: ()
    }
    return nil
  }
  
}
