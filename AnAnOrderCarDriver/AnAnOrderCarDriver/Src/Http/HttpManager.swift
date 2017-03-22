//
//  HttpManager.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/22.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import Alamofire

class HttpManager: NSObject {
    
    static let sharedManager:HttpManager = HttpManager()
    
    private override init() {
        super.init()
    }
    
    func sendHttpMessage(httpMsg:HttpMessage) -> Void {
        let method:SSRequestMethod = httpMsg.requestMethod
    }
}
