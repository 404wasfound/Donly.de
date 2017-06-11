//
//  ConversationViewdModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/10/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import JSQMessagesViewController

protocol ConversationViewModelProtocol {
  var messages: Variable<[JSQMessage]?> { get set }
  func getMessagesForConversation()
  var delegate: ConversationVCProtocol? { get set }
}

class ConversationViewModel: ConversationViewModelProtocol {
  
  var id: Int
  var messages = Variable<[JSQMessage]?>(nil)
  var disposeBag = DisposeBag()
  var delegate: ConversationVCProtocol?
  
  init(withConversationId id: Int) {
    self.id = id
  }
  
  func getMessagesForConversation() {
    delegate?.showIndicator()
    let messagesRequest = ConversationMessagesAPIRequest(withUserId: self.id)
    messagesRequest.send().subscribe(onNext: { result in
      switch result {
      case .success(let messages):
        print("Number of messages: \(messages.count)")
        self.createJSQmessages(fromMessages: messages)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }, onError: { error in
      ///
    }, onCompleted: { 
      self.delegate?.hideIndicator()
    }).addDisposableTo(disposeBag)
  }
  
  func createJSQmessages(fromMessages messages: [Message]) {
    let jsqMessages = messages.flatMap { $0.getJSQMessage() }
    self.messages.value = jsqMessages
  }
  
}
