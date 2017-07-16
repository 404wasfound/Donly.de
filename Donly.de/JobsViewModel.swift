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
  func openAllJobsScreen()
  func getJobs(forPull pull: Bool)
  func openJob(_ job: Job)
  var page: MainScene.MainPage { get set }
  var delegate: JobsVCProtocol? { get set }
  var jobs: Variable<[Job]?> { get set }
}

class JobsViewModel: JobsViewModelProtocol {
  
  private var mainRouter: MainRouterProtocol?
  private var mainVM: MainViewModelProtocol?
  var page: MainScene.MainPage
  var delegate: JobsVCProtocol?
  var disposeBag = DisposeBag()
  var jobs = Variable<[Job]?>(nil)
  
  init(withMainRouter router: MainRouterProtocol, andMainVM mainVM: MainViewModelProtocol, forPage page: MainScene.MainPage) {
    self.mainRouter = router
    self.mainVM = mainVM
    self.page = page
  }
  
  func openAllJobsScreen() {
    mainRouter?.routeToAllJobs()
  }
  
  func getJobs(forPull pull: Bool) {
    var parameters = [String: String]()
    if page == .myTasks {
      parameters = ["filter": "performer"]
    } else if page == .allTasks {
      ///nothing for now
    }
    mainVM?.showIndicator()
    let jobsRequest = JobsAPIRequest(withParameters: parameters)
    jobsRequest.send().subscribe(onNext: { result in
      if let error = result.error {
        print("Some weird error: \(error)")
      } else if let jobs = result.result {
        print("Number of jobs: \(jobs.count)")
        self.jobs.value = jobs
        self.mainVM?.hideIndicator()
      }
    }, onError: { error in
      ///
    }, onCompleted: { 
      self.mainVM?.hideIndicator()
      if pull {
        self.delegate?.endRefreshing()
      }
    }) {
      self.mainVM?.hideIndicator()
    }.addDisposableTo(disposeBag)
  }
  
  func openJob(_ job: Job) {
    mainRouter?.routeToJob(job, withJobsVM: self)
  }
  
}
