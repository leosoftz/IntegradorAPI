//
//  MeliNetworkLogger.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//



import Foundation
import Alamofire

class MeliNetworkLogger: EventMonitor {
    func requestDidFinish(_ request: Request) {
        print(request.description)
    }
    
    func request<Value>(_ request: DataRequest,
                        didParseResponse response: DataResponse<Value,
                        AFError>) {
        guard let data = response.data else {
            return
        }
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            print(json)
        } else {
            print("MeliNetworkLogger: json no correct format")
        }
    }
}

