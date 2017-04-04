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
  var userToken: String? { get set }
  var userLocation: Variable<Location?> { get set }
}

typealias Location = (lon: Double, lat: Double)
var appData = ApplicationData.shared

class ApplicationData: ApplicationDataProtocol {

  static let shared = ApplicationData()
  init() {
    ///
  }
  var userToken: String? = nil
  var userLocation = Variable<Location?>(nil)
  
}
