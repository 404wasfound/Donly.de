//
//  MainViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol MainViewModelProtocol {
  func configureViewForContainer(withRouter router: MainRouterProtocol, andMainVC main: MainVCProtocol) -> UIViewController?
  func getBadgeCounterForPage(_ page: MainScene.MainPage)
  func showIndicator()
  func hideIndicator()
  func resetScenes()
  var page: MainScene.MainPage { get set }
  var currentScreen: UIViewController? { get set }
  var messagesCounter: Variable<Int?> { get set }
  var notificationsCounter: Variable<Int?> { get set }
  var mainVC: MainVCProtocol? { get set }
}

class MainViewModel: MainViewModelProtocol {
 
  var page: MainScene.MainPage
  var currentScreen: UIViewController?
  private var scenesForPages: [MainScene.MainPage: UIViewController?] = [:]
  var messagesCounter = Variable<Int?>(nil)
  var notificationsCounter = Variable<Int?>(nil)
  private var disposeBag = DisposeBag()
  var mainVC: MainVCProtocol?
  
  init(withPage page: MainScene.MainPage) {
    self.page = page
  }
  
  func configureViewForContainer(withRouter router: MainRouterProtocol, andMainVC main: MainVCProtocol) -> UIViewController? {
    if let vc = scenesForPages[page] {
      return vc
    }
    var vc: UIViewController?
    switch page {
    case .messages:
      vc = ConversationsScene.configure(withMainRouter: router, andMainVM: self)
    case .myTasks:
      vc = JobsScene.configure(withMainRouter: router, andMainVM: self, forPage: .myTasks)
    case .allTasks:
      vc = JobsScene.configure(withMainRouter: router, andMainVM: self, forPage: .allTasks)
    case .profile:
      vc = ProfileScene.configure(withMainRouter: router)
    case .notifications:
      vc = NotificationsScene.configure(withMainRouter: router, andMainVM: self)
    }
    scenesForPages[page] = vc
    return vc
  }
  
  func getBadgeCounterForPage(_ page: MainScene.MainPage) {
    var endpoint: Endpoint = .messagesCount
    switch page {
    case .notifications:
      endpoint = .notificationsCount
    default: ()
    }
    let request = BadgeCounterAPIRequest(withEndpoint: endpoint)
    request.send().subscribe(onNext: { result in
      if let error = result.error {
        print("Received error: \(error.getDescription())")
      } else if let counter = result.result {
        switch page {
        case .messages:
         self.messagesCounter.value = counter
        case .notifications:
          self.notificationsCounter.value = counter
        default: ()
        }
      }
    }, onError: { error in
      ///
    }, onCompleted: { 
      ///
    }).addDisposableTo(disposeBag)
  }
  
  func showIndicator() {
    mainVC?.showIndicator()
  }
  
  func hideIndicator() {
    mainVC?.hideIndicator()
  }
  
  func resetScenes() {
    scenesForPages = [:]
  }
  
}
