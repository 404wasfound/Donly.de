//
//  ProfileViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/11/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

protocol ProfileViewModelProtocol {
  func logoutCurrentUser()
  var delegate: ProfileVCProtocol? { get set }
}

class ProfileViewModel: ProfileViewModelProtocol {
  
  private var mainRouter: MainRouterProtocol?
  var delegate: ProfileVCProtocol?
  
  init(withMainRouter router: MainRouterProtocol) {
    self.mainRouter = router
  }
  
  func logoutCurrentUser() {
    appData.cleanUserData()
    let vc = OnboardingLoginScene.configure()
    delegate?.navigateTo(vc: vc)
  }
  
}
