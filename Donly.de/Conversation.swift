//
//  Conversation.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/7/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

struct Conversation {
  var id: Int
  var isRead: Bool
  var lastMessage: Message
  var user: User
}

extension Conversation: JSONSerializable {
  init?(json: JSON) {
    var id: Int?
    var isRead: Bool?
    var lastMessage: Message?
    var user: User?
    
    for (key, value) : (String, JSON) in json {
      switch key {
        case "id":
          id = value.int
        case "is_read":
          isRead = value.bool
        case "last_message":
          if let newMessage = Message(json: value) {
            lastMessage = newMessage
          }
        case "user":
          if let newUser = User(json: value) {
            user = newUser
          }
      default:
        print("[***] For Conversation object that key: (\(key)) is not parsed")
      }
    }
    guard let parsedId = id, let parsedIsRead = isRead, let parsedLastMessage = lastMessage, let parsedUser = user else {
      return nil
    }
    self.id = parsedId
    self.isRead = parsedIsRead
    self.lastMessage = parsedLastMessage
    self.user = parsedUser
  }
}
