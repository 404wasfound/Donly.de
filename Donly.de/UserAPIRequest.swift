//
//  UserAPIRequest.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/8/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift

class UserAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var parameters: [String : String]
  var endpoint: Endpoint = .config
  typealias ReturnType = User
  
  init(parameters: [String: String]) {
    self.parameters = parameters
  }
  
  func requestData() -> Observable<User?> {
    let client = APIClient()
    return client.getObjects(resource: self).map { $0[0] }
  }
  
}
