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

enum UserDataAPIResult {
  case success(User)
  case failure(APIClientError)
}

final class UserDataAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var idParameter: String? = nil
  var parameters: [String: Any]
  var endpoint: Endpoint = .users
  var client: APIClient
  typealias ReturnType = UserDataAPIResult
  
  init(withUserId id: Int) {
    self.idParameter = "\(id)"
    self.parameters = [:]
    self.client = APIClient()
  }
  
  func send() -> Observable<UserDataAPIResult> {
    return client.getData(resource: self)
      .catchError({ error in
        throw error
      })
      .map { result in
        switch result {
        case .success(let data):
          let json = JSON(data: data)
          print("JSON from \(String(describing: UserDataAPIRequest.self)): ")
          print(json)
          guard self.checkForSucces(inJson: json) else {
            return .failure(APIClientError.successFailure)
          }
          let jsonData = json["item"]
          if let user = User(json: jsonData) {
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
