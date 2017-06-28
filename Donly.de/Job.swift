//
//  Job.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/20/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

enum JobStatus: String {
  case opened = "opened"
  case inProgress = "in_process"
  case finished = "finished"
  case blocked = "blocked"
  
  func getStatusName() -> String {
    switch self {
      case .opened: return "Waiting"
      case .inProgress: return "In Progress"
      case .finished: return "Completed"
      case .blocked: return "Closed"
    }
  }
  
  func getImageName() -> String {
    switch self {
      case .finished: return "icon_job_status_finished"
      case .inProgress: return "icon_job_status_inprogress"
      case .blocked: return "icon_job_status_blocked"
      case .opened: return "icon_job_status_waiting"
    }
  }
}

struct Job {
  var id: Int
  var url: String
  var status: JobStatus
  var category: JobCategory
  var title: String
  var description: String
  var address: Address
  var cost: Cost
  var jobDate: JobDate
  var performer: User?
  var owner: User
  var closedSetting: Bool
  var commentsBlocked: Bool
  var isBlocked: Bool
  var reviewsNumber: Int
  var commentsNumber: Int
}

extension Job: JSONSerializable {
  init?(json: JSON) {
    var id: Int?
    var url: String?
    var status: JobStatus?
    var categoryId: Int?
    var subCategoryId: Int?
    var title: String?
    var description: String?
    var address: Address?
    var cost: Cost?
    var jobDate: JobDate?
    var performer: User?
    var owner: User?
    var closedSetting: Bool = false
    var commentsBlocked: Bool = false
    var isBlocked: Bool = false
    var reviewsNumber: Int = 0
    var commentsNumber: Int = 0
    for (key, value) : (String, JSON) in json {
      switch key {
        case "id":
          id = value.int
        case "url":
          url = value.string
        case "item":
          for (newKey, newValue) : (String, JSON) in value {
            switch newKey {
              case "status":
                if let statusRaw = newValue.string {
                  status = JobStatus(rawValue: statusRaw)
                }
              case "category_id":
                subCategoryId = newValue.int
              case "parent_cat_id":
                categoryId = newValue.int
              case "desc":
                description = newValue.string
              case "text":
                title = newValue.string
              case "address":
                address = Address(json: newValue)
              case "cost":
                cost = Cost(json: newValue)
              case "date":
                jobDate = JobDate(json: newValue)
            default:
              print("[***] For Job object that key: (\(newKey)) is not parsed")
            }
          }
        case "performer":
          performer = User(json: value)
        case "owner":
          owner = User(json: value)
        case "settings":
          for (newKey, newValue) : (String, JSON) in value {
            switch newKey {
              case "closed":
                closedSetting = newValue.boolValue
              case "is_disabled_comments":
                commentsBlocked = newValue.boolValue
              case "is_blocked":
                isBlocked = newValue.boolValue
            default:
              print("[***] For JobDate object that key: (\(newKey)) is not parsed")
            }
          }
        case "count_reviews":
          reviewsNumber = value.intValue
        case "count_comments":
          commentsNumber = value.intValue
      default:
        print("[***] For JobDate object that key: (\(key)) is not parsed")
      }
    }
    var category: JobCategory?
    if let categoryId = categoryId, let subCategoryId = subCategoryId, let jobCategoryType = JobCategoryType(rawValue: categoryId) {
      category = JobCategory(id: categoryId, jobCategoryType: jobCategoryType, subCategory: JobSubCategory(id: subCategoryId))
    }
    guard let idParsed = id, let urlParsed = url, let statusParsed = status, let categoryParsed = category, let titleParsed = title, let descriptionParsed = description, let addressParsed = address, let costParsed = cost, let jobDateParsed = jobDate, let ownerParsed = owner else {
      return nil
    }
    self.id = idParsed
    self.url = urlParsed
    self.status = statusParsed
    self.category = categoryParsed
    self.title = titleParsed
    self.description = descriptionParsed
    self.address = addressParsed
    self.cost = costParsed
    self.jobDate = jobDateParsed
    self.performer = performer
    self.owner = ownerParsed
    self.closedSetting = closedSetting
    self.commentsBlocked = commentsBlocked
    self.isBlocked = isBlocked
    self.reviewsNumber = reviewsNumber
    self.commentsNumber = commentsNumber
  }
}
