//
//  JobScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/16/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class JobScene {
  
  static func configure(forJob job: Job, withMainRouter router: MainRouterProtocol, andWithJobsVM jobsVM: JobsViewModelProtocol) -> JobVC {
    let viewModel = JobViewModel(forJob: job, withMainRouter: router, andWithJobsVM: jobsVM)
    return JobVC(withViewModel: viewModel)
  }
  
}
