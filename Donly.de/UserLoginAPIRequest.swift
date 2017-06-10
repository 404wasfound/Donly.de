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

enum UserLoginAPIResult {
  case success(User)
  case failure(APIClientError)
}

final class UserLoginAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var idParameter: String? = nil
  var parameters: [String : String]
  var endpoint: Endpoint = .login
  var client: APIClient
  typealias ReturnType = UserLoginAPIResult
  
  init(parameters: [String: String]) {
    self.parameters = parameters
    self.client = APIClient()
  }
  
  func send() -> Observable<UserLoginAPIResult> {
    return client.getData(resource: self)
      .catchError({ error in
        throw error
      })
      .map { result in
        switch result {
        case .success(let data):
          let json = JSON(data: data)
          print("JSON from \(String(describing: UserLoginAPIRequest.self)): ")
          print(json)
          let loginToken = json["loginToken"].string
          let jsonData = json["item"]
          guard self.checkForSucces(inJson: json) else {
            return .failure(APIClientError.successFailure)
          }
          if var user = User(json: jsonData) {
            user.token = loginToken
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
