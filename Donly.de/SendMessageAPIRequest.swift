//
//  SendMessageAPIRequest.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/11/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

enum SendMessageAPIResult {
  case success(Message)
  case failure(APIClientError)
}

final class SendMessageAPIRequest: APIRequestType {
  
  var method: HTTPMethod = .post
  var idParameter: String? = nil
  var parameters: [String : Any]
  var endpoint: Endpoint = .messages
  var client: APIClient
  typealias ReturnType = SendMessageAPIResult
  
  init(withUserId id: Int, withMessage text: String) {
    self.idParameter = "\(id)"
    self.parameters = ["message": text]
    self.client = APIClient()
  }
  
  func send() -> Observable<SendMessageAPIResult> {
    return client.getData(resource: self)
      .catchError({ error in
        throw error
      })
      .map { result in
        switch result {
        case .success(let data):
          let json = JSON(data: data)
          print("JSON from \(String(describing: SendMessageAPIRequest.self)): ")
          print(json)
          guard self.checkForSucces(inJson: json) else {
            return .failure(APIClientError.successFailure)
          }
          let jsonData = json["item"]
          guard let message = Message(json: jsonData) else {
            return .failure(APIClientError.serializationJSONFailed)
          }
          return .success(message)
        case .failure(let error):
          return .failure(error)
        }
    }
  }
  
}
