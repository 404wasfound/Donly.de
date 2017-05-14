//
//  APIRequest.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/8/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import RxSwift

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
}

enum Endpoint: String {
  case config = "login"
}

protocol APIRequest {
  var method: HTTPMethod { get }
  var endpoint: Endpoint { get }
  var parameters: [String: String] { get }
}

protocol APIRequestType: APIRequest {
  associatedtype ReturnType: Any
  func requestData() -> Observable<ReturnType?>
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
    request.httpMethod = method.rawValue
    return request
  }
}
