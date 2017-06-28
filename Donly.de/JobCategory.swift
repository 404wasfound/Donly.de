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
  
  func getImageName() -> String {
    switch self {
      case .computerHelp: return "icon_job_it"
      case .craftWork: return "icon_job_craft"
      case .householdWork: return "icon_job_household"
      case .deliveryService: return "icon_job_delivery"
      case .transportationHelp: return "icon_job_transportation"
      case .otherServices: return "icon_job_other"
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
