//
//  PhoneNumber.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/6/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

struct PhoneNumber {
  var prefix: String
  var phone: String
}

extension PhoneNumber {
  func getPhoneNumber() -> String {
    return "+" + prefix + phone
  }
}
