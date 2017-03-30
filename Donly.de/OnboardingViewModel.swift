//
//  OnboardingViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 3/30/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift

enum Page: String {
  case first = "first"
  case second = "second"
  case third = "third"
}

protocol OnboardingViewModelProtocol {
  var text: Variable<String> { get set }
  var page: Page { get set }
}

extension OnboardingViewModelProtocol {
}

class OnboardingViewModel: OnboardingViewModelProtocol {
  
  var text: Variable<String>
  var page: Page
  
  init(page: Page) {
    switch page {
    case .first:
      self.text = Variable("The first")
    case .second:
      self.text = Variable("The second")
    case .third:
      self.text = Variable("The third")
    }
    self.page = page
  }
  
}
