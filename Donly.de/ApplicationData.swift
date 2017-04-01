//
//  ApplicationData.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/1/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

protocol ApplicationDataProtocol {
  var userToken: String? { get set }
  var userLocation: String? { get set }
}

class ApplicationData: ApplicationDataProtocol {
  var userToken: String?
  var userLocation: String?
}
