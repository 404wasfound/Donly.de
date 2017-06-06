//
//  MainMessagesViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/6/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift

protocol MainMessagesViewModelProtocol {
  var messages: Variable<[Message]?> { get set }
  var currentView: Variable<UIView?> { get set }
}

class MainMessagesViewModel: MainMessagesViewModelProtocol {
  
  var messages = Variable<[Message]?>(nil)
  var currentView = Variable<UIView?>(nil)
  
  init() {
    self.sendMessagesRequest()
  }
  
  func sendMessagesRequest() {
    ///
  }
  
  func configureView() {
    ///
  }
  
}
