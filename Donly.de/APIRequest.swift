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
  case messages = "messages"
  case users = "users"
  case jobs = "jobs"
}

protocol APIRequest {
  var method: HTTPMethod { get }
  var endpoint: Endpoint { get }
  var parameters: [String: Any] { get }
  var idParameter: String? { get set }
}

extension APIRequest {
  func makeRequest() -> URLRequest {
    guard let url = URL(string: appSet.url.appending(endpoint.rawValue)), var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      fatalError("Unable to create URL components.")
    }
    if let parameter = idParameter,
      let urlWithParameter = URL(string: url.absoluteString.appending("/" + parameter)),
      let newComponents = URLComponents(url: urlWithParameter, resolvingAgainstBaseURL: false) {
      components = newComponents
    } else {
      components.queryItems = parameters.map {
        URLQueryItem(name: String($0), value: String(describing: $1))
      }
    }
    guard let finalUrl = components.url else {
      fatalError("Unable to get URL with parameters.")
    }
    var request = URLRequest(url: finalUrl)
    if method == .post {
      request.httpBody = createHttpBodyString(parameters: parameters).data(using: .utf8)
    }
    if let userData = appData.userData {
      request.addValue(userData.token, forHTTPHeaderField: "login-token")
      print("login-token: \(userData.token)")
    }
    request.httpMethod = method.rawValue
    print("Firing request to the (\(String(describing: request.url?.absoluteString)))")
    return request
  }
  
  func createHttpBodyString(parameters: [String: Any]) -> String {
    var bodyString: String = ""
    for param in parameters {
      if !bodyString.isEmpty {
        bodyString = bodyString + ", "
      }
      bodyString = bodyString + "\"\(param.key)\":\"\(param.value)\""
    }
    bodyString = "{" + bodyString + "}"
    return bodyString
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
    } else {
      print("[***] SUCCESS: FALSE")
    }
    return success
  }
  
}

protocol APIRequestType: APIRequest {
  associatedtype ReturnType: Any
  func process(jsonData: JSON) -> (result: ReturnType?, error: APIClientError?)
}

extension APIRequestType {
  
  func send() -> Observable<(result: ReturnType?, error: APIClientError?)> {
    return APIClient.getData(resource: self).catchError({ error in
      throw error
    }).map({ result in
      switch result {
      case .success(let data):
        let jsonData = JSON(data: data)
        guard self.checkForSucces(inJson: jsonData) else {
          return (result: nil, error: APIClientError.successFailure)
        }
        let parsedResult = self.process(jsonData: jsonData)
        if let error = parsedResult.error {
          return (result: nil, error: error)
        } else if let result = parsedResult.result {
          return (result: result, error: nil)
        } else {
          return (result: nil, error: APIClientError.serializationJSONFailed)
        }
      case .failure(let error):
        return (result: nil, error: error)
      }
    })
  }
  
}
