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
  var conversations: Variable<[Conversation]?> { get set }
  var currentView: Variable<UIView?> { get set }
}

class MainMessagesViewModel: MainMessagesViewModelProtocol {
  
  var conversations = Variable<[Conversation]?>(nil)
  var currentView = Variable<UIView?>(nil)
  var disposeBag = DisposeBag()
  
  init() {
    self.sendMessagesRequest()
  }
  
  func sendMessagesRequest() {
    let conversationsRequest = ConversationsAPIRequest()
    conversationsRequest.send().subscribe(onNext: { result in
      switch result {
      case .success(let conversations):
        print("Number of conversations: \(conversations.count)")
        self.conversations.value = conversations
      case .failure(let error):
        print(error)
      }
    }, onError: { error in
      ///
    }, onCompleted: { 
      ///
    }).addDisposableTo(disposeBag)
  }
  
  func configureView() {
    ///
  }
  
}
