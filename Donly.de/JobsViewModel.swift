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
  
}

class JobsViewModel: JobsViewModelProtocol {
  
  private var mainRouter: MainRouterProtocol?
  
  init(withMainRouter router: MainRouterProtocol) {
    self.mainRouter = router
  }
}
