//
//  MeliApiManager.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import Foundation
import Alamofire

class MeliApiManager: NSObject {
    static let shared = MeliApiManager()
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        let networkLogger = MeliNetworkLogger()
        let interceptor = MeliRequestInterceptor()
        return Session(configuration: configuration,
                       interceptor: interceptor,
                       cachedResponseHandler: responseCacher,
                       eventMonitors: [networkLogger])
    }()
}
