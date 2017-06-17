//
//  UserLoginAPIRequest.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/8/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

final class UserLoginAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var idParameter: String? = nil
  var parameters: [String: Any]
  var endpoint: Endpoint = .login
  typealias ReturnType = User
  
  init(parameters: [String: String]) {
    self.parameters = parameters
  }
  
  func process(jsonData: JSON) -> (result: User?, error: APIClientError?) {
    print("JSON from \(String(describing: UserLoginAPIRequest.self)): ")
    print(jsonData)
    let loginToken = jsonData["loginToken"].string
    let jsonUserData = jsonData["item"]
    guard var user = User(json: jsonUserData) else {
      return (result: nil, error: APIClientError.serializationJSONFailed)
    }
    user.token = loginToken
    return (result: user, error: nil)
  }
}
