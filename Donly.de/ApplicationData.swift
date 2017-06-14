//
//  ApplicationData.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift

protocol ApplicationDataProtocol {
  var userData: UserData? { get set }
  var user: User? { get set }
  var userLocation: Variable<Location?> { get set }
  func readUserData()
}

typealias Location = (lon: Double, lat: Double)
typealias UserData = (token: String, userId: Int)
var appData = ApplicationData.shared

class ApplicationData: ApplicationDataProtocol {
  
  static let shared = ApplicationData()
  var userData: UserData? = nil
  var user: User? = nil {
    didSet {
      if let newUser = user, let token = newUser.token {
        let userData = (token: token, userId: newUser.id)
        self.writeUserData(userData)
      }
    }
  }
  var userLocation = Variable<Location?>(nil)
  
}

extension ApplicationData {
  
  func writeUserData(_ data: UserData) {
    self.userData = data
    UserDefaults.standard.set(data.token, forKey: "token")
    UserDefaults.standard.set(data.userId, forKey: "userId")
  }
  
  func readUserData() {
    if let token = UserDefaults.standard.object(forKey: "token") as? String {
      let userId = UserDefaults.standard.integer(forKey: "userId")
      self.userData = (token: token, userId: userId)
    }
  }
  
  func setCurrent(location: Location?) {
    self.userLocation = Variable(location)
  }
}
