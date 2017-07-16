//
//  NotificationsViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/12/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift

protocol NotificationsViewModelProtocol {
  func getNotifications(forPull pull: Bool)
  var notifications: Variable<[Notification]?> { get set }
  var delegate: NotificationsVCProtocol? { get set }
}

class NotificationsViewModel: NotificationsViewModelProtocol {
  
  private var mainRouter: MainRouterProtocol?
  private var mainVM: MainViewModelProtocol?
  var disposeBag = DisposeBag()
  var notifications = Variable<[Notification]?>(nil)
  var delegate: NotificationsVCProtocol?
  
  init(withMainRouter router: MainRouterProtocol?, andMainVM mainVM: MainViewModelProtocol?) {
    self.mainRouter = router
    self.mainVM = mainVM
  }
  
  func getNotifications(forPull pull: Bool) {
    mainVM?.showIndicator()
    let notificationsRequest = NotificationsAPIRequest()
    notificationsRequest.send().subscribe(onNext: { result in
      if let error = result.error {
        print("Some weird error: \(error)")
      } else if let notifications = result.result {
        print("Number of notifications: \(notifications.count)")
        self.notifications.value = notifications
        self.mainVM?.hideIndicator()
      }
    }, onError: { error in
      ///
    }, onCompleted: { 
      self.mainVM?.hideIndicator()
      if pull {
        self.delegate?.endRefreshing()
      }
      self.mainVM?.getBadgeCounterForPage(MainScene.MainPage.notifications)
    }) {
      self.mainVM?.hideIndicator()
    }.addDisposableTo(disposeBag)
  }
  
}
