//
//  ConversationViewdModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/10/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift

protocol ConversationViewModelProtocol {
  var messages: Variable<[Message]?> { get set }
  func getMessagesForConversation()
}

class ConversationViewModel: ConversationViewModelProtocol {
  
  var id: Int
  var messages = Variable<[Message]?>(nil)
  var disposeBag = DisposeBag()
  
  init(withConversationId id: Int) {
    self.id = id
  }
  
  func getMessagesForConversation() {
    let messagesRequest = ConversationMessagesAPIRequest(withUserId: self.id)
    messagesRequest.send().subscribe(onNext: { result in
      switch result {
      case .success(let messages):
        print("Number of messages: \(messages.count)")
        self.messages.value = messages
      case .failure(let error):
        print(error.localizedDescription)
      }
    }, onError: { error in
      ///
    }, onCompleted: { 
      ///
    }).addDisposableTo(disposeBag)
  }
  
}
