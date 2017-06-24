//
//  JobDate.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/23/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

enum JobDateType: String {
  case for30days = "for_30_days"
  case forDate = "for_date"
  case forDefinedDate = "for_defined_date"
  case now = "now"
}

struct JobDate {
  var dateTime: Date
  var date: Date
  var type: JobDateType
}

extension JobDate: JSONSerializable {
  init?(json: JSON) {
    var dateTime: Date?
    var date: Date?
    var type: JobDateType?
    for (key, value) : (String, JSON) in json {
      switch key {
        case "datetime":
          if let dateRaw = value.int {
            dateTime = Date(timeIntervalSince1970: Double(dateRaw))
          }
        case "date":
          date = Date()
        case "option":
          if let jobTypeRaw = value.string {
            type = JobDateType(rawValue: jobTypeRaw)
          }
      default:
        print("[***] For JobDate object that key: (\(key)) is not parsed")
      }
    }
    guard let dateTimeParsed = dateTime, let dateParsed = date, let typeParsed = type else {
      return nil
    }
    self.dateTime = dateTimeParsed
    self.date = dateParsed
    self.type = typeParsed
  }
}
