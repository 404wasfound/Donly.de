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
  var user: User? { get set }
  var userLocation: Variable<Location?> { get set }
}

typealias Location = (lon: Double, lat: Double)
var appData = ApplicationData.shared

class ApplicationData: ApplicationDataProtocol {

  static let shared = ApplicationData()
  var user: User? = nil
  var userLocation = Variable<Location?>(nil)
  
}

extension ApplicationData {
  func setCurrent(location: Location?) {
    self.userLocation = Variable(location)
  }
}
