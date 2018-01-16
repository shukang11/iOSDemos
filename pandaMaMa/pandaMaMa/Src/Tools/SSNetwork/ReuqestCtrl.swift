//
//  ReuqestCtrl.swift
//  pandaMaMa
//
//  Created by tree on 2018/1/15.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import Alamofire

class RequestCtrl: NSObject {
    static let `shared` = RequestCtrl()
    
    let manager = { () -> SessionManager in
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        let manage = Alamofire.SessionManager(configuration: config)
        return manage
    }()
    
    private override init() {
        
    }
    
    //MARK:-
    //MARK:Public
    public func push(request: BaseRequest) -> Void {
        var cusRequest: URLRequest? = request.buildCustomRequest()
        if cusRequest != nil {
            
        }else {
            
        }
    }
    
    public func cancel(request: BaseRequest) -> Void {
        
    }
    
}




