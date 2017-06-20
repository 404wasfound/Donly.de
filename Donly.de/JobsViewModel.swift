//
//  JobsViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/17/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift

protocol JobsViewModelProtocol {
  var page: MainScene.MainPage { get set }
  func openAllJobsScreen()
}

class JobsViewModel: JobsViewModelProtocol {
  
  private var mainRouter: MainRouterProtocol?
  var page: MainScene.MainPage
  
  init(withMainRouter router: MainRouterProtocol, forPage page: MainScene.MainPage) {
    self.mainRouter = router
    self.page = page
  }
  
  func openAllJobsScreen() {
    mainRouter?.routeToAllJobs()
  }
  
}
