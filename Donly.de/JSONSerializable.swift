//
//  JSONSerializable.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/8/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONSerializable {
  init?(json: JSON)
}

func deserialize<T: JSONSerializable>(json: JSON) -> T? {
  return T(json: json)
}

func deserialize<T: JSONSerializable>(json: JSON) -> [T]? {
  if let array = json.array {
    return array.flatMap { T(json: $0) }
  } else if let object: T = deserialize(json: json) {
    return [object]
  }
  return nil
}
