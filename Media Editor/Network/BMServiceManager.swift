//
//  BMServiceManager.swift
//
//  Created by Baptiste
//  Copyright © 2019 BM. All rights reserved.
//

import Foundation
import Alamofire

class BMServiceManager: NSObject {
    
    private static let instance = BMServiceManager()
    
    open class var `default`: BMServiceManager {
        return instance
    }
    
    private override init() {
        super.init()
    }

    let hostName: String = "https://api.openweathermap.org/"
    
    static let apiKey = "f81027c9d6277cc5e15cbf13406c0228"

    var apiRootUrl: URL {
        return URL(string: "\(hostName)/data/2.5")!
    }
    
    func urlForService(_ service: String) -> URL {
        return apiRootUrl.appendingPathComponent(service)
    }
}

extension BMServiceManager {
    
    func request(route: BMRoute,
                 parameters: [String: AnyObject]?,
                 completion: ((BMResponse) -> Void)?) {
     
        let url = self.urlForService(route.serviceName)
        let method = route.httpMethod
        
        self.request(url: url,
                     method: method,
                     parameters: parameters,
                     completion: completion)
    }
    
    func request(url: URL,
                 method: HTTPMethod,
                 parameters: [String: AnyObject]?,
                 completion: ((BMResponse) -> Void)?) {
                
        let encoding: ParameterEncoding
            = (method == .get) ? URLEncoding.default : JSONEncoding.default
        
        BMNetworkManager.default.sessionManager.request(url, method: method, parameters: parameters, encoding: encoding, headers: nil).responseJSON { (response) in
            
            if let data = response.data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject {

                let r = BMResponse(code: 200, value: json)
                completion?(r)
                return
            }
            
            let r = BMResponse(code: 999, value: "Invalid Server Response")
            completion?(r)
            return
        }
        return
    }    
}
