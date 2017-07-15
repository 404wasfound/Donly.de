//
//  BadgeCounterAPIRequest.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/15/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

final class BadgeCounterAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var idParameter: String? = nil
  var parameters: [String : Any] = [:]
  var endpoint: Endpoint
  typealias ReturnType = Int
  
  init(withEndpoint endpoint: Endpoint) {
    self.endpoint = endpoint
  }
  
  func process(jsonData: JSON) -> (result: Int?, error: APIClientError?) {
    print("JSON from \(String(describing: BadgeCounterAPIRequest.self)) for endpoint: \(self.endpoint.rawValue): ")
    print(jsonData)
    let item = jsonData["item"]
    guard let count = item["count"].int else {
      return (result: nil, error: APIClientError.serializationJSONFailed)
    }
    return (result: count, error: nil)
  }
  
}
