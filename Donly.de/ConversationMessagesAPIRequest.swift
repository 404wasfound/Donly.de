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

final class ConversationMessagesAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var idParameter: String? = nil
  var parameters: [String: Any]
  var endpoint: Endpoint = .messages
  typealias ReturnType = [Message]
  
  init(withUserId id: Int) {
    self.idParameter = "\(id)"
    self.parameters = [:]
  }
  
  func process(jsonData: JSON) -> (result: [Message]?, error: APIClientError?) {
    print("JSON from \(String(describing: ConversationMessagesAPIRequest.self)): ")
    print(jsonData)
    let jsonMessagesData = jsonData["items"]
    guard let messages: [Message] = deserialize(json: jsonMessagesData) else {
      return (result: nil, error: APIClientError.serializationJSONFailed)
    }
    return (result: messages.reversed(), error: nil)
  }

}
