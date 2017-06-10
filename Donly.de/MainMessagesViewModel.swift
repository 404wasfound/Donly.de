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
  func sendMessagesRequest(withDelegata delegate: MainMessagesVCProtocol?)
}

class MainMessagesViewModel: MainMessagesViewModelProtocol {
  
  var conversations = Variable<[Conversation]?>(nil)
  var disposeBag = DisposeBag()
  
  init() {
    self.sendMessagesRequest(withDelegata: nil)
  }
  
  func sendMessagesRequest(withDelegata delegate: MainMessagesVCProtocol?) {
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
      delegate?.endRefreshing()
    }).addDisposableTo(disposeBag)
  }
  
  func configureView() {
    ///
  }
  
}
