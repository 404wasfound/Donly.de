//
//  ApplicationSettings.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

protocol ApplicationSettingsProtocol {
  var url: String { get }
  var onboardingShown: Bool { get }
  static var shared: ApplicationSettingsProtocol { get }
  static func getShared() -> ApplicationSettingsProtocol
}

class ApplicationSettings: ApplicationSettingsProtocol {
  static var shared: ApplicationSettingsProtocol = ApplicationSettings()
  static func getShared() -> ApplicationSettingsProtocol {
    return shared
  }
  
  var url: String {
    if let baseUrl = Bundle.main.infoDictionary?["BASE_URL"] as? String {
      return baseUrl
    } else {
      return ""
    }
  }
  
  var onboardingShown: Bool {
    return UserDefaults.standard.bool(forKey: "OnboardingShown")
  }
  
}
