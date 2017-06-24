//
//  JobSubCategory.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/24/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

struct JobSubCategory {
  var id: Int
}

extension JobSubCategory: JSONSerializable {
  init?(json: JSON) {
    ///Currently empty
    return nil
  }
}
