//
//  MeliRequestInterceptor.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//


import UIKit
import Alamofire

class MeliRequestInterceptor: RequestInterceptor {
    let retryLimit = 3
    let retryDelay: TimeInterval = 10
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if let token = UserDefaults.standard.object(forKey: "token") {
            let bearerToken = "Bearer \(token)"
            print("BEARER TOKEN ES \(bearerToken)")
            urlRequest.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        }
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        let response = request.task?.response as? HTTPURLResponse
        if let statusCode = response?.statusCode,(500...599).contains(statusCode),
           request.retryCount < retryLimit {
            completion(.retryWithDelay(retryDelay))
        } else {
            return completion(.doNotRetry)
        }
    }
}


