//
//  ConversationsViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/6/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift

protocol ConversationsViewModelProtocol {
  var conversations: Variable<[Conversation]?> { get set }
  var delegate: ConversationsVCProtocol? { get set }
  func getConversations(forPull: Bool)
  func openConversation(_ conversation: Conversation)
}

class ConversationsViewModel: ConversationsViewModelProtocol {
  
  var conversations = Variable<[Conversation]?>(nil)
  var disposeBag = DisposeBag()
  var delegate: ConversationsVCProtocol?
  private var mainRouter: MainRouterProtocol?
  private var mainVC: MainVCProtocol?
  
  init(withMainRouter router: MainRouterProtocol, andMainVC main: MainVCProtocol) {
    self.mainRouter = router
    self.mainVC = main
  }
  
  func getConversations(forPull pull: Bool) {
    let conversationsRequest = ConversationsAPIRequest()
    mainVC?.showIndicator()
    conversationsRequest.send().subscribe(onNext: { result in
      if let error = result.error {
        print(error.getDescription())
      } else if let conversations = result.result {
        print("Number of conversations: \(conversations.count)")
        self.conversations.value = conversations
      }
    }, onError: { error in
      ///
    }, onCompleted: {
      self.mainVC?.hideIndicator()
      if pull {
        self.delegate?.endRefreshing()
      }
    }).addDisposableTo(disposeBag)
  }
  
  func openConversation(_ conversation: Conversation) {
    mainRouter?.routeToConversation(conversation)
  }
  
}
