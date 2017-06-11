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
  var delegate: ConversationVCProtocol? { get set }
  func getMessagesForConversation()
  func sendMessage(withText text: String)
}

class ConversationViewModel: ConversationViewModelProtocol {
  
  var conversation: Conversation
  var messages = Variable<[JSQMessage]?>(nil)
  var disposeBag = DisposeBag()
  var delegate: ConversationVCProtocol?
  
  init(withConversation conversation: Conversation) {
    self.conversation = conversation
  }
  
  func getMessagesForConversation() {
    delegate?.showIndicator()
    let messagesRequest = ConversationMessagesAPIRequest(withUserId: self.conversation.user.id)
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
    let jsqMessages = messages.map { $0.getJSQMessage() }
    self.messages.value = jsqMessages
  }
  
  func sendMessage(withText text: String) {
    let sendMessageRequest = SendMessageAPIRequest(withUserId: conversation.user.id, withMessage: text)
    sendMessageRequest.send().subscribe(onNext: { result in
      switch result {
      case .success(let message):
        let jsqMessage = message.getJSQMessage()
        self.messages.value?.append(jsqMessage)
        self.delegate?.endSendingMessage()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }, onError: { error in
      ///
    }, onCompleted: { 
      ///
    }).addDisposableTo(disposeBag)
    print("Message with text: (\(text)) is sent!")
  }
  
}
