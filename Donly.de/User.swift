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
  var token: String
  var id: Int
  var email: String
  var firstName: String
  var lastName: String
  var imagePath: String
  var phoneNumber: PhoneNumber
}
extension User: JSONSerializable {
  init?(json: JSON) {
    var token: String?
    var id: Int?
    var email: String?
    var firstName: String?
    var lastName: String?
    var imagePath: String?
    var phoneNumber: PhoneNumber?
    
    for (key, value) : (String, JSON) in json {
      switch key {
        case "loginToken":
        token = value.stringValue
        case "item":
          for (key, value) : (String, JSON) in value {
            switch key {
              case "id":
                id = value.int
              case "email":
                email = value.string
              case "first_name":
                firstName = value.string
              case "last_name":
                lastName = value.string
              case "full_img_path":
                imagePath = value.string
              case "phone":
                var prefix: Int?
                var phone: Int?
                for (key, value) : (String, JSON) in value {
                  switch key {
                    case "prefix":
                    prefix = value.int
                    case "phone":
                    phone = value.int
                  default: ()
                  }
                }
                guard let prefixParsed = prefix, let phoneParsed = phone else {
                  return nil
                }
                phoneNumber = PhoneNumber(prefix: "\(prefixParsed)", phone: "\(phoneParsed)")
            default:
              print("[***] WILL PARSE (\(key)) LATER WHEN NEEDED")
            }
        }
      default: ()
      }
    }
    guard let tokenParsed = token, let parsedId = id, let parsedEmail = email, let firstNameParsed = firstName, let lastNameParsed = lastName, let imagePathParsed = imagePath, let phoneNumberParsed = phoneNumber else {
      return nil
    }
    self.token = tokenParsed
    self.id = parsedId
    self.email = parsedEmail
    self.firstName = firstNameParsed
    self.lastName = lastNameParsed
    self.imagePath = imagePathParsed
    self.phoneNumber = phoneNumberParsed
  }
  
  var fullName: String {
    return firstName + " " + lastName
  }
}
