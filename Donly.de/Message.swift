//
//  Message.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/6/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift
import JSQMessagesViewController

struct Message {
  var id: Int?
  var message: String
  var sentDate: Date
  var isRead: Bool
  var user: User
}

extension Message: JSONSerializable {
  
  init?(json: JSON) {
    var id: Int?
    var message: String?
    var sentDate: Date?
    var isRead: Bool?
    var user: User?
    
    for (key, value) : (String, JSON) in json {
      switch key {
        case "id":
          id = value.int
        case "message":
          message = value.string
        case "sent_at":
          if let date = value.int {
            sentDate = Date(timeIntervalSince1970: Double(date))
          }
        case "is_read":
          isRead = value.bool
        case "user":
          if let newUser = User(json: value) {
            user = newUser
          }
      default:
        print("[***] For Message object that key: (\(key)) is not parsed")
      }
    }
    guard let parsedMessage = message, let parsedSentDate = sentDate, let parsedIsRead = isRead, let parsedUser = user else {
      return nil
    }
    self.id = id
    self.message = parsedMessage
    self.sentDate = parsedSentDate
    self.isRead = parsedIsRead
    self.user = parsedUser
  }
}

extension Message {
  func getJSQMessage() -> JSQMessage? {
    guard let id = self.id else {
      return nil
    }
    return JSQMessage(senderId: String(describing: id), senderDisplayName: user.fullName, date: sentDate, text: message)
  }
}

