//
//  BLinFire.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/11/17.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
class BLinFire {
    @discardableResult
    open class func GET(_ url:URLConvertible, method:HTTPMethod? = .get, parameters:Parameters? = nil,success:@escaping (_ data:Data, _ request:URLRequest, _ response:URLResponse)->())->Reuqest? {
        return SessionManager.sharedInstance.GET(url, method: method, parameters: parameters, success: success)
    }
}

extension URLRequest {
    public func request() {
        
    }
}
