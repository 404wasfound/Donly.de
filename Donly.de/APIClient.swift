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

enum APIClientError: Error {
  case serializationJSONFailed
  case wrongHTTP(status: Int)
  case other(Error)
}

final class APIClient {
  func getObjects<T: JSONSerializable>(resource: APIResource) -> Observable<[T]> {
    return getData(resource: resource).map { data in
      let json = JSON(data: data)
      guard let objects: [T] = deserialize(json: json) else {
        throw APIClientError.serializationJSONFailed
      }
      return objects
    }
  }
  
  private func getData(resource: APIResource) -> Observable<Data> {
    let request = resource.makeRequest()
    return Observable.create { observer in
      Alamofire.request(request).responseData(completionHandler: { data in
        if let error = data.error {
          observer.onError(APIClientError.other(error))
        }
        guard let response = data.response, let receivedData = data.data else {
          fatalError("Get HTTP response failed.")
        }
        if 200 ..< 300 ~= response.statusCode {
          observer.onNext(receivedData)
          observer.onCompleted()
        } else {
          observer.onError(APIClientError.wrongHTTP(status: response.statusCode))
        }
      })
      return Disposables.create()
    }
  }
  
}
