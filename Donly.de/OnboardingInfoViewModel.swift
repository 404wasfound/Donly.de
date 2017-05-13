//
//  OnboardingInfoViewModel.swift
//  Donly.de
//
//  Created by Bogdan Yur on 5/13/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

typealias OnboardingInfoElement = (title: String, description: String)

protocol OnboardingInfoViewModelProtocol {
  var firstElement: OnboardingInfoElement { get }
  var secondElement: OnboardingInfoElement { get }
  var thirdElement: OnboardingInfoElement { get }
}

final class OnboardingInfoViewModel: OnboardingInfoViewModelProtocol {
  
  var firstElement: OnboardingInfoElement
  var secondElement: OnboardingInfoElement
  var thirdElement: OnboardingInfoElement
  
  init() {
    self.firstElement = (title: "Donly ist kostenlos", description: "Bei donly kann einen Job anbieten und ausführen - 100% provisionsfrei")
    self.secondElement = (title: "Donly ist direkt", description: "Donly verbindet Auftraggerber und Helfer direkt - schnell, effizient und ohne Vermittlung")
    self.thirdElement = (title: "Donly ist veielfaltig", description: "Bei donly können Sie jeden Job anbieten oder ausführen. Sie sind nicht auf die bestehende Kategorien beschränkt")
  }
  
}
