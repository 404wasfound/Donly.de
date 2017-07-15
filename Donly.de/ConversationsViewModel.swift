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
  private var mainVM: MainViewModelProtocol?
  
  init(withMainRouter router: MainRouterProtocol, andMainVM mainVM: MainViewModelProtocol) {
    self.mainRouter = router
    self.mainVM = mainVM
  }
  
  func getConversations(forPull pull: Bool) {
    let conversationsRequest = ConversationsAPIRequest()
    mainVM?.showIndicator()
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
      self.mainVM?.hideIndicator()
      if pull {
        self.delegate?.endRefreshing()
        self.mainVM?.getBadgeCounterForPage(MainScene.MainPage.messages)
      }
    }).addDisposableTo(disposeBag)
  }
  
  func openConversation(_ conversation: Conversation) {
    mainRouter?.routeToConversation(conversation)
  }
  
}
