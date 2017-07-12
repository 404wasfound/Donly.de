//
//  Notification.swift
//  Donly.de
//
//  Created by Bogdan Yur on 7/12/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

struct Notification {
  var id: Int
  var message: String
  var dateCreated: Date
  var jobId: Int
  var jobTitle: String
  var author: User
  var isRead: Bool
  var isButton: Bool
  var isForm: Bool
}

extension Notification: JSONSerializable {
  init?(json: JSON) {
    var id: Int?
    var message: String?
    var dateCreated: Date?
    var jobId: Int?
    var jobTitle: String?
    var author: User?
    var isRead: Bool = false
    var isButton: Bool = false
    var isForm: Bool = false
    for (key, value) : (String, JSON) in json {
      switch key {
        case "id":
          id = value.int
        case "notification":
          for (key, value) : (String, JSON) in value {
            switch key {
              case "message":
                message = value.string
              case "created_at":
                if let dateRaw = value.int {
                  dateCreated = Date(timeIntervalSince1970: Double(dateRaw))
                }
            default: ()
            }
          }
        case "task":
          for (key, value) : (String, JSON) in value {
            switch key {
              case "job_id":
                jobId = value.int
              case "title":
                jobTitle = value.string
            default: ()
            }
          }
        case "author":
          author = User(json: value)
        case "settings":
          for (key, value) : (String, JSON) in value {
            switch key {
              case "is_read":
                isRead = value.boolValue
              case "is_button":
                isButton = value.boolValue
              case "is_form":
                isForm = value.boolValue
            default: ()
            }
          }
      default: ()
      }
    }
    guard let idParsed = id, let messageParsed = message, let dateCreatedParsed = dateCreated, let jobIdParsed = jobId, let jobTitleParsed = jobTitle, let authorParsed = author else {
      return nil
    }
    self.id = idParsed
    self.message = messageParsed
    self.dateCreated = dateCreatedParsed
    self.jobId = jobIdParsed
    self.jobTitle = jobTitleParsed
    self.author = authorParsed
    self.isRead = isRead
    self.isButton = isButton
    self.isForm = isForm
  }
}
