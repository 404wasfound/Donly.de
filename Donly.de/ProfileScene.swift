//
//  ProfileScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/11/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class ProfileScene {
  
  static func configure(withMainRouter router: MainRouterProtocol) -> ProfileVC {
    let viewModel = ProfileViewModel(withMainRouter: router)
    return ProfileVC(withViewModel: viewModel)
  }
  
}
