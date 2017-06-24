//
//  Cost.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/24/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

enum CostType: String {
  case opened = "opened"
  case perJob = "per_job"
  case perHour = "per_hour"
}

struct Cost {
  var costValue: Double
  var type: CostType
}

extension Cost: JSONSerializable {
  init?(json: JSON) {
    var costValue: Double?
    var type: CostType?
    for (key, value): (String, JSON) in json {
      switch key {
        case "cost":
        costValue = value.double
        case "option":
          if let typeRaw = value.string {
            type = CostType(rawValue: typeRaw)
          }
      default:
        print("[***] For Cost object that key: (\(key)) is not parsed")
      }
    }
    guard let costValueParsed = costValue, let typeParsed = type else {
      return nil
    }
    self.costValue = costValueParsed
    self.type = typeParsed
  }
}
