//
//  JobsScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/17/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class JobsScene {
  
  static func configure(withMainRouter router: MainRouterProtocol, andMainVM mainVM: MainViewModelProtocol, forPage page: MainScene.MainPage) -> JobsVC {
    let viewModel = JobsViewModel(withMainRouter: router, andMainVM: mainVM, forPage: page)
    return JobsVC(withViewModel: viewModel)
  }
  
}
