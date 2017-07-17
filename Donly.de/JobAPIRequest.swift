//
//  JobAPIRequest.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/16/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

final class JobAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var idParameter: String?
  var parameters: [String: Any] = [:]
  var endpoint: Endpoint = .jobs
  typealias ReturnType = Job
  
  init(withId id: Int) {
    self.idParameter = "\(id)"
  }
  
  func process(jsonData: JSON) -> (result: Job?, error: APIClientError?) {
    print("JSON from \(String(describing: JobAPIRequest.self)):")
    print(jsonData)
    let jsonJobData = jsonData["item"]
    guard let job: Job = deserialize(json: jsonJobData) else {
      return (result: nil, error: APIClientError.serializationJSONFailed)
    }
    return (result: job, error: nil)
  }
  
}
