//
//  BMRequest.swift
//
//  Created by Baptiste
//  Copyright © 2019 BM. All rights reserved.
//

import Foundation
import Alamofire

typealias BMRequestResponseHandler = (BMRequest, BMResponse) -> Void

enum BMAuthenticationType: Int {
    case
    none = 0,
    app = 1,
    oauth = 2
}

/// A type representing an API Route
struct BMRoute {
    var serviceName: String
    var httpMethod: HTTPMethod
    var authLevel: BMAuthenticationType
}

extension BMRoute {
    
    static var weatherInfos: BMRoute {
        return BMRoute(serviceName: "weather",
            httpMethod: .get,
            authLevel: .app)
    }
}

/// A type representing an API request
class BMRequest: NSObject {
    
    var route: BMRoute
    var parameters: [String: AnyObject]?
        
    var responseHandler: BMRequestResponseHandler?
    
    /// Create an instance of the request
    /// - Parameters:
    ///   - route: Route to user
    ///   - dataUpload: `true` if a file is going to be uploaded
    ///   - parameters: additional parameters
    init(route: BMRoute,
         parameters: [String: AnyObject]? = nil) {
        
        self.route = route
        self.parameters = parameters
    }
    
    /// Send the request with the previously specified configuration
    func send() {
        
        var p = parameters ?? [:]
        
        if self.route.authLevel == .app {
            p["appid"] = BMServiceManager.apiKey as AnyObject
        }
                
        BMServiceManager.default.request(route: route,
                                         parameters: p,
                                         completion: { (response) in
                                            self.responseHandler?(self, response)
        })
    }
}

struct BMResponse {
    
    fileprivate var _valueObj: AnyObject
    
    var code: Int
    var error: String? {
        return _valueObj as? String
    }
    var value: [String: AnyObject]? {
        return _valueObj as? [String: AnyObject]
    }
    
    init(code: Int, value: AnyObject) {
        self.code = code
        self._valueObj = value
    }
    
    init(code: Int, value: String) {
        self.code = code
        self._valueObj = value as AnyObject
    }
}
