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

final class ConversationsAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var idParameter: String? = nil
  var parameters: [String: Any]
  var endpoint: Endpoint = .conversations
  typealias ReturnType = [Conversation]
  
  init() {
    self.parameters = [:]
  }
  
  func process(jsonData: JSON) -> (result: [Conversation]?, error: APIClientError?) {
    print("JSON from \(String(describing: ConversationsAPIRequest.self)): ")
    print(jsonData)
    let jsonConversationsData = jsonData["items"]
    guard let conversations: [Conversation] = deserialize(json: jsonConversationsData) else {
      return (result: nil, error: APIClientError.serializationJSONFailed)
    }
    return (result: conversations, error: nil)
  }
  
}
