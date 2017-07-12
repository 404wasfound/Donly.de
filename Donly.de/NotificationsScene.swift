//
//  NotificationsScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/12/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class NotificationsScene {
  
  static func configure(withMainRouter router: MainRouterProtocol, andMainVC main: MainVCProtocol) -> NotificationsVC {
    let viewModel = NotificationsViewModel(withMainRouter: router, andMainVC: main)
    return NotificationsVC(withViewModel: viewModel)
  }
  
}
