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

final class SendMessageAPIRequest: APIRequestType {
  var method: HTTPMethod = .post
  var idParameter: String? = nil
  var parameters: [String: Any]
  var endpoint: Endpoint = .messages
  typealias ReturnType = Message
  
  init(withUserId id: Int, withMessage text: String) {
    self.idParameter = "\(id)"
    self.parameters = ["message": text]
  }
  
  func process(jsonData: JSON) -> (result: Message?, error: APIClientError?) {
    print("JSON from \(String(describing: SendMessageAPIRequest.self)): ")
    print(jsonData)
    let jsonMessageData = jsonData["item"]
    guard let message = Message(json: jsonMessageData) else {
      return (result: nil, error: APIClientError.serializationJSONFailed)
    }
    return (result: message, error: nil)
  }
  
}
