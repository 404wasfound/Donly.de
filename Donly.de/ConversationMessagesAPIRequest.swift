//
//  ConversationMessagesAPIRequest.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/10/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

enum ConversationMessagesAPIResult {
  case success([Message])
  case failure(APIClientError)
}

final class ConversationMessagesAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var idParameter: String? = nil
  var parameters: [String : String]
  var endpoint: Endpoint = .messages
  var client: APIClient
  typealias ReturnType = ConversationMessagesAPIResult
  
  init(withUserId id: Int) {
    self.idParameter = "\(id)"
    self.parameters = [:]
    self.client = APIClient()
  }
  
  func send() -> Observable<ConversationMessagesAPIResult> {
    return client.getData(resource: self)
      .catchError({ error in
      throw error
      })
      .map { result in
        switch result {
        case .success(let data):
          let json = JSON(data: data)
          print("JSON from \(String(describing: ConversationMessagesAPIRequest.self)): ")
          print(json)
          guard self.checkForSucces(inJson: json) else {
            return .failure(APIClientError.successFailure)
          }
          let jsonData = json["items"]
          guard let messages: [Message] = deserialize(json: jsonData) else {
            return .failure(APIClientError.serializationJSONFailed)
          }
          return .success(messages)
        case .failure(let error):
          return .failure(error)
        }
    }
  }
}
