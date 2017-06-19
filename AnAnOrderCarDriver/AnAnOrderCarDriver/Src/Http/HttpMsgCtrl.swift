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
    
    var messages:[String : HttpMessage] = [:]
    
    private init() {
        
    }
    /// 发送一个请求
    ///
    /// - Parameter message: 封装好的请求参数
    public func sendMessage(message:HttpMessage) -> Void {
        self.messages[message.requestUrl] = message
        weak var weakSelf = self
        Alamofire.request(message.requestUrl, method: message.requestMethod, parameters: message.parame, encoding: message.paramsEncoding, headers: message.headers).responseJSON { (response) in
            if response.result.isSuccess {
                weakSelf?.requestDidFinished(response: response)
            }else if response.result.isFailure {
                weakSelf?.requestDidFaild(response: response)
            }
            
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
        message.jsonItems  = jsonData.dictionaryObject!
        message.responseStatusCode = (response.response?.statusCode)!
        message.delegate?.receiveDidFinished(receiveMsg: message)
    }
    
    func requestDidFaild(response:DataResponse<Any>) {
        guard let url = response.request?.url?.absoluteString else { return }
        guard let message = messages[url] else { return }
        message.responseStatusCode = (response.response?.statusCode)!
        message.error = response.error
        message.delegate?.receiveDidFailed(receiveMsg: message)
    }
}
