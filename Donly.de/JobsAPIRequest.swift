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
  typealias ReturnType = Job
  
  init(withParameters parameters: [String: String] = [:], withIdParameter id: String? = nil) {
    self.parameters = parameters
    self.idParameter = id
  }
  
  func process(jsonData: JSON) -> (result: Job?, error: APIClientError?) {
    print("JSON from \(String(describing: JobsAPIRequest.self)):")
    print(jsonData)
    return (result: nil, error: nil)
  }
  
}






//http://update.donly.de/api/v1/jobs?filter=owner
