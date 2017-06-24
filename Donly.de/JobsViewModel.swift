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
  var delegate: JobsVCProtocol? { get set }
  func openAllJobsScreen()
  func getJobs(forPull pull: Bool)
  var jobs: Variable<[Job]?> { get set }
}

class JobsViewModel: JobsViewModelProtocol {
  
  private var mainRouter: MainRouterProtocol?
  var page: MainScene.MainPage
  var delegate: JobsVCProtocol?
  var disposeBag = DisposeBag()
  var jobs = Variable<[Job]?>(nil)
  
  init(withMainRouter router: MainRouterProtocol, forPage page: MainScene.MainPage) {
    self.mainRouter = router
    self.page = page
  }
  
  func openAllJobsScreen() {
    mainRouter?.routeToAllJobs()
  }
  
  func getJobs(forPull pull: Bool) {
    var parameters = [String: String]()
    if page == .myTasks {
      parameters = ["filter": "owner"]
    } else if page == .allTasks {
      ///nothing for nowß
    }
    delegate?.showIndicator()
    let jobsRequest = JobsAPIRequest(withParameters: parameters)
    jobsRequest.send().subscribe(onNext: { result in
      if let error = result.error {
        print("Some weird error")
      } else if let jobs = result.result {
        print("Number of jobs: \(jobs.count)")
        self.jobs.value = jobs
      }
    }, onError: { error in
      ///
    }, onCompleted: { 
      self.delegate?.hideIndicator()
      if pull {
        self.delegate?.endRefreshing()
      }
    }).addDisposableTo(disposeBag)
  }
  
}
