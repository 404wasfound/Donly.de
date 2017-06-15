//
//  Date+Extensions.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/16/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

extension Date {
  
  func isSameDay(asDate date: Date) -> Bool {
    let calendar = Calendar.current
    let comparingDateYear = calendar.component(.year, from: date)
    let comparingDateMonth = calendar.component(.month, from: date)
    let comparingDateDay = calendar.component(.day, from: date)
    let year = calendar.component(.year, from: self)
    let month = calendar.component(.month, from: self)
    let day = calendar.component(.day, from: self)
    if comparingDateYear == year, comparingDateMonth == month, comparingDateDay == day {
      return true
    }
    return false
  }
  
  func isDayBefore(thenDate date: Date) -> Bool {
    let calendar = Calendar.current
    let comparingDateYear = calendar.component(.year, from: date)
    let comparingDateMonth = calendar.component(.month, from: date)
    let comparingDateDay = calendar.component(.day, from: date)
    let year = calendar.component(.year, from: self)
    let month = calendar.component(.month, from: self)
    let day = calendar.component(.day, from: self)
    if comparingDateYear == year, comparingDateMonth == month, day == comparingDateDay - 1 {
      return true
    }
    return false
  }
  
}
