//
//  JobViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/16/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

protocol JobViewModelProtocol {
  ///
}

class JobViewModel: JobViewModelProtocol {
  
  private var job: Job
  private var mainRouter: MainRouterProtocol?
  private var jobsVM: JobsViewModelProtocol?
  
  init(forJob job: Job, withMainRouter router: MainRouterProtocol, andWithJobsVM jobsVM: JobsViewModelProtocol) {
    self.job = job
    self.mainRouter = router
    self.jobsVM = jobsVM
  }
  
}
