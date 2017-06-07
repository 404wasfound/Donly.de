//
//  APIRequest.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/8/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
}

enum Endpoint: String {
  case login = "system/login"
  case conversations = "dialogs"
}

protocol APIRequest {
  var method: HTTPMethod { get }
  var endpoint: Endpoint { get }
  var parameters: [String: String] { get }
  var client: APIClient { get set }
}

protocol APIRequestType: APIRequest {
  associatedtype ReturnType: Any
  func send() -> Observable<ReturnType>
}

extension APIRequest {
  func makeRequest() -> URLRequest {
    guard let url = URL(string: appSet.url.appending(endpoint.rawValue)), var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      fatalError("Unable to create URL components.")
    }
    components.queryItems = parameters.map {
      URLQueryItem(name: String($0), value: String($1))
    }
    guard let finalUrl = components.url else {
      fatalError("Unable to get URL with parameters.")
    }
    var request = URLRequest(url: finalUrl)
    if let currentUser = appData.user, let token = currentUser.token {
      request.addValue(token, forHTTPHeaderField: "login-token")
    }
    request.httpMethod = method.rawValue
    return request
  }
  
  func checkForSucces(inJson json: JSON) -> Bool {
    var success: Bool = false
    for (key, value) : (String, JSON) in json {
      switch key {
      case "success":
        success = value.boolValue
      default: ()
      }
    }
    if success {
      print("[***] SUCCESS: TRUE")
    }
    return success
  }
}
