//
//  JobCategory.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/24/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

enum JobCategoryType: Int {
  case computerHelp = 1
  case craftWork = 2
  case householdWork = 5
  case deliveryService = 6
  case transportationHelp = 7
  case otherServices = 8
  
  func getCategoryName() -> String {
    return "JOB CATEGORY NAME"
  }
  
  func getImageName() -> String {
    switch self {
      case .computerHelp:       return "icon_job_it"
      case .craftWork:          return "icon_job_craft"
      case .householdWork:      return "icon_job_household"
      case .deliveryService:    return "icon_job_delivery"
      case .transportationHelp: return "icon_job_transportation"
      case .otherServices:      return "icon_job_other"
    }
  }
  
  func getColor() -> UIColor {
    switch self {
      case .computerHelp: return UIColor(red: 0.506, green: 0.231, blue: 0.737, alpha: 1.0)
      case .craftWork: return UIColor(red:1.000, green:0.357, blue:0.196, alpha:1.00)
      case .householdWork: return UIColor(red:0.000, green:0.765, blue:0.984, alpha:1.00)
      case .deliveryService: return UIColor(red:1.000, green:0.000, blue:0.627, alpha:1.00)
      case .transportationHelp: return UIColor(red:0.000, green:0.706, blue:0.510, alpha:1.00)
      case .otherServices: return UIColor(red:0.416, green:0.416, blue:0.416, alpha:1.00)
    }
  }
}


struct JobCategory {
  var id: Int
  var jobCategoryType: JobCategoryType
  var subCategory: JobSubCategory
}

extension JobCategory: JSONSerializable {
  init?(json: JSON) {
    /// Currently empty
    return nil
  }
}
