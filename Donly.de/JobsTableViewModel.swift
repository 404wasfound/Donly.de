//
//  JobsTableViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/8/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

protocol JobsTableViewModelProtocol {
  var testJobs: [String] { get set }
}

class JobsTableViewModel: JobsTableViewModelProtocol {
  var testJobs: [String]
  
  init() {
    self.testJobs = ["one", "two", "three", "four", "five", "six", "seven", "one", "two", "three", "four", "five", "six", "seven", "one", "two", "three", "four", "five", "six", "seven"]
  }
}
