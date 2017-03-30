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
  var page: Variable<Page> { get set }
}

extension OnboardingViewModelProtocol {
}

class OnboardingViewModel: OnboardingViewModelProtocol {
  
  var text: Variable<String>
  var page: Variable<Page>
  
  init(page: Page) {
    switch page {
    case .first:
      self.text = Variable("The first onboarding page about how good is the service, why to use it, what benefits to the user and all that stuff")
    case .second:
      self.text = Variable("The second onboarding page about how good is the service, why to use it, what benefits to the user and all that stuff")
    case .third:
      self.text = Variable("The third onboarding page about how good is the service, why to use it, what benefits to the user and all that stuff")
    }
    self.page = Variable(page)
  }
  
}
