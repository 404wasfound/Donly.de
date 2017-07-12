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
  
}

class NotificationsViewModel: NotificationsViewModelProtocol {
  
  private var mainRouter: MainRouterProtocol?
  private var mainVC: MainVCProtocol?
  
  init(withMainRouter router: MainRouterProtocol?, andMainVC main: MainVCProtocol?) {
    self.mainRouter = router
    self.mainVC = main
  }
  
}
