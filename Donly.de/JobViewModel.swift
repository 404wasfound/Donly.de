//
//  JobViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/16/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift

protocol JobViewModelProtocol {
  func getJobDetails()
  var job: Variable<Job?> { get set }
}

class JobViewModel: JobViewModelProtocol {
  
  private var jobId: Int
  private var mainRouter: MainRouterProtocol?
  private var jobsVM: JobsViewModelProtocol?
  var job = Variable<Job?>(nil)
  private var disposeBag = DisposeBag()
  
  init(forJobId jobId: Int, withMainRouter router: MainRouterProtocol, andWithJobsVM jobsVM: JobsViewModelProtocol) {
    self.jobId = jobId
    self.mainRouter = router
    self.jobsVM = jobsVM
  }
  
  func getJobDetails() {
    let jobRequest = JobAPIRequest(withId: jobId)
    jobRequest.send().subscribe(onNext: { result in
      if let error = result.error {
        print("Receoved error: \(error.getDescription())")
      } else if let job = result.result {
        print("Job info received here!")
        self.job.value = job
      }
    }, onError: { error in
      ///
    }, onCompleted: { 
      ///
    }) { 
      ///
    }.addDisposableTo(disposeBag)
  }
  
}
