//
//  HttpMsgCtrl.swift
//  AnAnOrderCarDriver
//
//  Created by tree on 2017/6/18.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class HttpMsgCtrl {
    
    static let sharedCtrl = HttpMsgCtrl()
    let manager = { () -> SessionManager in 
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        let manage = Alamofire.SessionManager(configuration: config)
        return manage
    }()
    var messages:[String : HttpMessage] = [:]
    
    private init() {
        
    }
    /// 发送一个请求
    ///
    /// - Parameter message: 封装好的请求参数
    public func sendMessage(message:HttpMessage) -> Void {
        self.messages[message.requestUrl] = message
        
        manager.request(message.requestUrl, method: message.requestMethod, parameters: message.parame, encoding: message.paramsEncoding, headers: message.headers).validate().responseJSON { (response) in
            self.requestDidFinished(response: response)
        }
    }
    
    /// 取消一个请求
    ///
    /// - Parameter msg: 封装好的请求参数
    func cancelRequest(msg: HttpMessage) -> Void {
        
    }
    
    //MARK:-
    //MARK:Handle with block
    func requestDidFinished(response:DataResponse<Any>) {
        guard let url = response.request?.url?.absoluteString else { return }
        guard let message = messages[url] else { return }
        let jsonData = JSON.init(data: response.data!)
        message.errorCode = response.response?.statusCode ?? 0
        message.responseStatusCode = jsonData["statusCode"].intValue
        message.json = jsonData.dictionaryObject
        message.bodyObject = jsonData["body"].object as AnyObject
        message.error = response.error
        message.delegate?.receiveDidFinished(receiveMsg: message)
    }
}
