//
//  NotificationsAPIRequest.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/12/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

final class NotificationsAPIRequest: APIRequestType {
  var method: HTTPMethod = .get
  var idParameter: String? = nil
  var parameters: [String: Any]
  var endpoint: Endpoint = .notifications
  typealias ReturnType = [Notification]
  
  init(parameters: [String: String] = [:]) {
    self.parameters = parameters
  }
  
  func process(jsonData: JSON) -> (result: [Notification]?, error: APIClientError?) {
    print("JSON from \(String(describing: NotificationsAPIRequest.self)): ")
    print(jsonData)
    let jsonNotificationsData = jsonData["items"]
    guard let notifications: [Notification] = deserialize(json: jsonNotificationsData) else {
      return (result: nil, error: APIClientError.serializationJSONFailed)
    }
    return (result: notifications, error: nil)
  }
  
}
