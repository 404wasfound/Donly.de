//
//  DateManager.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/15/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class DateManager {
  
  static func getFormattedDate(fromDate date: Date) -> String {
    let currentDate = Date()
    let months = DateFormatter().shortMonthSymbols
    let calendar = Calendar.current
    if date.isSameDay(asDate: currentDate) {
      let hour = calendar.component(.hour, from: date)
      let minute = calendar.component(.minute, from: date)
      var minuteString = "\(minute)"
      if minute < 10 {
        minuteString = "0\(minute)"
      }
      return "\(hour):\(minuteString)"
    } else if date.isDayBefore(thenDate: currentDate) {
      return "Yesterday"
    }
    let day = calendar.component(.day, from: date)
    let month = calendar.component(.month, from: date)
    guard let monthName = months?[month - 1] else {
      return ""
    }
    return "\(day) \(monthName)"
  }

}
