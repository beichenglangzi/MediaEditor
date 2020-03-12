//
//  BMNetworkManager.swift
//
//  Created by Baptiste
//  Copyright © 2019 BM. All rights reserved.
//

import Foundation
import Alamofire

/// A signleton used to manage network connections
class BMNetworkManager: NSObject {
    
    private static let instance = BMNetworkManager()
    
    open class var `default`: BMNetworkManager {
        return instance
    }
    
    private override init() {
        super.init()
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.urlCache = nil
        
        let manager = Alamofire.SessionManager(configuration:configuration)
        defaultSessionManager = manager
    }
    
    private var defaultSessionManager: Alamofire.SessionManager!
    
    open var sessionManager: Alamofire.SessionManager {
        return defaultSessionManager
    }
}
