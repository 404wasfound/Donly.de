//
//  JobsAPIRequest.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/20/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

final class JobsAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var idParameter: String?
  var parameters: [String : Any]
  var endpoint: Endpoint = .jobs
  typealias ReturnType = [Job]
  
  init(withParameters parameters: [String: String] = [:]) {
    self.parameters = parameters
  }
  
  func process(jsonData: JSON) -> (result: [Job]?, error: APIClientError?) {
    print("JSON from \(String(describing: JobsAPIRequest.self)):")
    print(jsonData)
    let jsonJobsData = jsonData["items"]
    guard let jobs: [Job] = deserialize(json: jsonJobsData) else {
      return (result: nil, error: APIClientError.serializationJSONFailed)
    }
    return (result: jobs, error: nil)
  }
  
}
