//
//  UserDataAPIRequest.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/15/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

final class UserDataAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var idParameter: String? = nil
  var parameters: [String: Any]
  var endpoint: Endpoint = .users
  typealias ReturnType = User
  
  init(withUserId id: Int) {
    self.idParameter = "\(id)"
    self.parameters = [:]
  }
  
  func process(jsonData: JSON) -> (result: User?, error: APIClientError?) {
    print("JSON from \(String(describing: UserDataAPIRequest.self)): ")
    print(jsonData)
    let jsonUserData = jsonData["item"]
    guard let user = User(json: jsonUserData) else {
      return (result: nil, error: APIClientError.serializationJSONFailed)
    }
    return (result: user, error: nil)
  }
}
