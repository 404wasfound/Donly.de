//
//  UserAPIRequest.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/8/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

enum UserAPIResult {
  case success(User)
  case failure(APIClientError)
}

class UserAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var parameters: [String : String]
  var endpoint: Endpoint = .login
  var client: APIClient
  typealias ReturnType = UserAPIResult
  
  init(parameters: [String: String]) {
    self.parameters = parameters
    self.client = APIClient()
  }
  
  func send() -> Observable<UserAPIResult> {
    return client.getData(resource: self).catchError({ error in
      throw error
    })
    .map { result in
      switch result {
      case .success(let data):
        let json = JSON(data: data)
        print(json)
        guard self.checkForSucces(inJson: json) else {
          return .failure(APIClientError.successFailure)
        }
        if let user = User(json: json) {
          return .success(user)
        } else {
          return .failure(APIClientError.serializationJSONFailed)
        }
      case .failure(let error):
        return .failure(error)
      }
    }
  }
}
