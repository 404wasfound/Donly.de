//
//  MainViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

protocol MainViewModelProtocol {
  
}

class MainViewModel: MainViewModelProtocol {
 
  var page: MainScene.MainPage
  
  init(withPage page: MainScene.MainPage) {
    self.page = page
  }
  
}
