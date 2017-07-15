//
//  NotificationsScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/12/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class NotificationsScene {
  
  static func configure(withMainRouter router: MainRouterProtocol, andMainVM mainVM: MainViewModelProtocol) -> NotificationsVC {
    let viewModel = NotificationsViewModel(withMainRouter: router, andMainVM: mainVM)
    return NotificationsVC(withViewModel: viewModel)
  }
  
}
