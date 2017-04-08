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

class User: JSONSerializable {
  var name: String = ""
  var email: String = ""
  var token: String = ""
  
  required init?(json: JSON) {
    for (key, value) : (String, JSON) in json {
      switch key {
        case "name":
        self.name = value.stringValue
        case "email":
        self.email = value.stringValue
        case "token":
        self.token = value.stringValue
      default: ()
      }
    }
  }
}
