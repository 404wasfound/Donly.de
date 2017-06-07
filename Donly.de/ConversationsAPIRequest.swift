//
//  ConversationsAPIRequest.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/8/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

enum ConversationsAPIResult {
  case success([Conversation])
  case failure(APIClientError)
}

final class ConversationsAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var parameters: [String : String]
  var endpoint: Endpoint = .conversations
  var client: APIClient
  typealias ReturnType = ConversationsAPIResult
  
  init() {
    self.parameters = [:]
    self.client = APIClient()
  }
  
  func send() -> Observable<ConversationsAPIResult> {
    return client.getData(resource: self)
      .catchError({ error in
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
          let jsonData = json["items"]
          guard let conversations: [Conversation] = deserialize(json: jsonData) else {
            return .failure(APIClientError.serializationJSONFailed)
          }
          return .success(conversations)
        case .failure(let error):
          return .failure(error)
       }
    }
  }
}
