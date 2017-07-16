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
  func getMessagesForConversation()
  func sendMessage(withText text: String)
  func refreshConversationsListIfNeeded()
  func refreshBadgeIfNeeded()
  var messages: Variable<[JSQMessage]?> { get set }
  var delegate: ConversationVCProtocol? { get set }
  var profileImageUrl: String { get }
}

class ConversationViewModel: ConversationViewModelProtocol {
  
  var conversation: Conversation
  var messages = Variable<[JSQMessage]?>(nil)
  var profileImageUrl: String
  var disposeBag = DisposeBag()
  var delegate: ConversationVCProtocol?
  var conversationsVM: ConversationsViewModel?
  private var willNeedToReloadConversations = false
  private var willNeedToReloadBadge = false
  
  init(withConversation conversation: Conversation, withConvsVM convsVM: ConversationsViewModel) {
    self.conversation = conversation
    self.profileImageUrl = conversation.user.imagePath
    self.conversationsVM = convsVM
  }
  
  func getMessagesForConversation() {
    delegate?.showIndicator()
    let messagesRequest = ConversationMessagesAPIRequest(withUserId: self.conversation.user.id)
    messagesRequest.send().subscribe(onNext: { result in
      if let error = result.error {
        print(error.getDescription())
      } else if let messages = result.result {
        print("Number of messages: \(messages.count)")
        self.createJSQmessages(fromMessages: messages)
        self.checkIfBadgeShouldBeReloaded()
      }
    }, onError: { error in
      ///
    }, onCompleted: { 
      self.delegate?.hideIndicator()
    }) {
      self.delegate?.hideIndicator()
    }.addDisposableTo(disposeBag)
  }
  
  func createJSQmessages(fromMessages messages: [Message]) {
    let jsqMessages = messages.map { $0.getJSQMessage() }
    self.messages.value = jsqMessages
  }
  
  func checkIfBadgeShouldBeReloaded() {
    if conversation.lastMessage.isRead == false {
      self.willNeedToReloadBadge = true
    }
  }
  
  func sendMessage(withText text: String) {
    let sendMessageRequest = SendMessageAPIRequest(withUserId: conversation.user.id, withMessage: text)
    sendMessageRequest.send().subscribe(onNext: { result in
      if let error = result.error {
        print(error.getDescription())
      } else if let message = result.result {
        let jsqMessage = message.getJSQMessage()
        self.messages.value?.append(jsqMessage)
        self.delegate?.endSendingMessage()
        print("Message with text: (\(text)) is sent!")
      }
    }, onError: { error in
      ///
    }, onCompleted: {
      if !self.willNeedToReloadConversations {
        self.willNeedToReloadConversations = true
        self.willNeedToReloadBadge = false
      }
    }).addDisposableTo(disposeBag)
  }
  
  func refreshConversationsListIfNeeded() {
    if willNeedToReloadConversations {
      self.conversationsVM?.getConversations(forPull: false)
    }
  }
  
  func refreshBadgeIfNeeded() {
    if willNeedToReloadBadge {
      self.conversationsVM?.refreshBadge()
    }
  }
  
}
