//
//  Address.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/24/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

enum City: Int {
  case berlin = 4
}

struct Address {
  var postcode: Int
  var city: City
  var addressString: String
  var location: Location
}

extension Address: JSONSerializable {
  init?(json: JSON) {
    var postcode: Int?
    var city: City?
    var addressString: String?
    var latitude: Double?
    var longitude: Double?
    for (key, value): (String, JSON) in json {
      switch key {
        case "zip":
          postcode = value.int
        case "city_id":
          if let cityIdRaw = value.int {
            city = City(rawValue: cityIdRaw)
          }
        case "address":
          addressString = value.string
        case "lat":
          latitude = value.double
        case "lon":
          longitude = value.double
      default:
        print("[***] For Address object that key: (\(key)) is not parsed")
      }
    }
    guard let postcodeParsed = postcode, let cityParsed = city, let addressParsed = addressString, let latitudeParsed = latitude, let longitudeParsed = longitude else {
      return nil
    }
    self.postcode = postcodeParsed
    self.city = cityParsed
    self.addressString = addressParsed
    self.location = (lat: latitudeParsed, lon: longitudeParsed)
  }
}
