//
//  User.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/8/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

struct User {
  var name: String
  var email: String
  var token: String
}
extension User: JSONSerializable {
  init?(json: JSON) {
    var name: String?
    var email: String?
    var token: String?
    for (key, value) : (String, JSON) in json {
      switch key {
        case "name":
        name = value.stringValue
        case "email":
        email = value.stringValue
        case "token":
        token = value.stringValue
      default: ()
      }
    }
    guard let nameParsed = name, let emailParsed = email, let tokenParsed = token else {
      return nil
    }
    self.name = nameParsed
    self.email = emailParsed
    self.token = tokenParsed
  }
}
