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
