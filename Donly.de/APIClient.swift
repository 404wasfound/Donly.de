//
//  APIClient.swift
//  Donly.de
//
//  Created by Bogdan Yur on 4/8/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

enum APIResponse {
  case success(Data)
  case failure(APIClientError)
}

enum APIClientError: Error {
  case serializationJSONFailed
  case wrongHTTP(status: Int)
  case noResponse
  case other(Error)
  case successFailure
  
  func getDescription() -> String {
    switch self {
    case .serializationJSONFailed:
      return "Serialized failed!"
    case .wrongHTTP(status: let status):
      return "The HTTP status is denied! Received status: \(status)"
    case .noResponse:
      return "No response received!"
    case .other(let error):
      return "Some weird error occured! Error: \(error)"
    case .successFailure:
      return "Success tag failed!"
    }
  }
  
}

final class APIClient {
  
  static func getData(resource: APIRequest) -> Observable<APIResponse> {
    let request = resource.makeRequest()
    return Observable.create { observer in
      Alamofire.request(request).responseData(completionHandler: { data in
        if let error = data.error {
          observer.onError(APIClientError.other(error))
        }
        guard let response = data.response, let receivedData = data.data else {
          observer.onNext(.failure(APIClientError.noResponse))
          observer.onCompleted()
          return
        }
        if 200 ..< 300 ~= response.statusCode {
          observer.onNext(.success(receivedData))
          observer.onCompleted()
        } else {
          observer.onNext(.failure(APIClientError.wrongHTTP(status: response.statusCode)))
        }
        observer.onCompleted()
      })
      return Disposables.create()
    }
  }
  
}
