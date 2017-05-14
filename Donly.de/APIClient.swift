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
  case failuer(Error)
}

enum APIClientError: Error {
  case serializationJSONFailed
  case wrongHTTP(status: Int)
  case noResponse
  case other(Error)
}

final class APIClient {
  
//  func getObjects<T: JSONSerializable>(resource: APIRequest) -> Observable<[T]> {
//    return getData(resource: resource).map { data in
//      let json = JSON(data: data)
//      print("[JSON]")
//      print(json)
//      guard let objects: [T] = deserialize(json: json) else {
//        throw APIClientError.serializationJSONFailed
//      }
//      return objects
//    }
//  }
  
  func getData(resource: APIRequest) -> Observable<APIResponse> {
    let request = resource.makeRequest()
    return Observable.create { observer in
      Alamofire.request(request).responseData(completionHandler: { data in
        if let error = data.error {
          observer.onError(APIClientError.other(error))
        }
        guard let response = data.response, let receivedData = data.data else {
          observer.onError(APIClientError.noResponse)
          return
        }
        if 200 ..< 300 ~= response.statusCode {
          observer.onNext(.success(receivedData))
          observer.onCompleted()
        } else {
          observer.onError(APIClientError.wrongHTTP(status: response.statusCode))
        }
      })
      return Disposables.create()
    }
  }
  
}
