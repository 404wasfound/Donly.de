//
//  MainViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/8/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift

enum MainPage {
  case alltasks
  case mytask
}

protocol MainViewModeltProtocol {
  var page: MainPage { get }
  func configureView() -> UIViewController?
}

class MainViewModelt: MainViewModeltProtocol {
  var page: MainPage
  
  init(page: MainPage) {
    self.page = page
  }
  
  func configureView() -> UIViewController? {
    switch page {
    case .alltasks:
      return JobsTableVC()
    case .mytask:
      print("my task screen")
    }
    return nil
  }
  
}
