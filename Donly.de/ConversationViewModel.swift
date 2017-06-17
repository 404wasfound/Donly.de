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
  var profileImageUrl: String { get }
  func getMessagesForConversation()
  func sendMessage(withText text: String)
}

class ConversationViewModel: ConversationViewModelProtocol {
  
  var conversation: Conversation
  var messages = Variable<[JSQMessage]?>(nil)
  var profileImageUrl: String
  var disposeBag = DisposeBag()
  var delegate: ConversationVCProtocol?
  
  init(withConversation conversation: Conversation) {
    self.conversation = conversation
    self.profileImageUrl = conversation.user.imagePath
  }
  
  func getMessagesForConversation() {
    delegate?.showIndicator()
    let messagesRequest = ConversationMessagesAPIRequest(withUserId: self.conversation.user.id)
    messagesRequest.send().subscribe(onNext: { result in
      if let error = result.error {
        print(error.localizedDescription)
      } else if let messages = result.result {
        print("Number of messages: \(messages.count)")
        self.createJSQmessages(fromMessages: messages)
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
      if let error = result.error {
        print(error.localizedDescription)
      } else if let message = result.result {
        let jsqMessage = message.getJSQMessage()
        self.messages.value?.append(jsqMessage)
        self.delegate?.endSendingMessage()
      }
    }, onError: { error in
      ///
    }, onCompleted: { 
      ///
    }).addDisposableTo(disposeBag)
    print("Message with text: (\(text)) is sent!")
  }
  
}
