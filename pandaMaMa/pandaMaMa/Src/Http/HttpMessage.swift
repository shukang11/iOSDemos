//
//  HttpMessage.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/17.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import Alamofire
// MARK: - 提供一些常用的方法,用于快速创建对象
extension HttpMessage {
    func defaultJSONHeaders() -> [String: String] {
        return ["Content-Type": "application/json"]
    }
}


class HttpMessage {
    //MARK:-
    //MARK:sending

    //发送的代码类型
    var cmdCode : E_CMDCODE = .CC_default
    //请求超时
    var timeout : Float = 15.0
    //请求的地址
    var requestUrl : String = ""
    //请求的参数
    var parame : [String: Any]?
    /// 请求头信息(can be nil)
    var headers: [String: String]?
    //请求的方法
    var requestMethod : HTTPMethod = .post
    //添加的用户信息(can be nil)
    var userInfo : AnyObject?
    //二进制流 e.g. 图片数据
    var postData : Data = Data.init()
    //能否传输图片
    var isUploadImage : Bool = false
    //请求回调
    var delegate : HttpResponseDelegate?
    
    /// 请求的参数类型。默认是Alamofire默认的参数。有的情况会需要json的类型，可以修改这里
    var paramsEncoding : ParameterEncoding = JSONEncoding()
    
    //MARK:-
    //MARK:recieving

    //回应的字符
    var responseString : String = ""
    //返回的全部信息
    var json: [String: Any]? = [:]
    //返回的主要内容
    var bodyObject: AnyObject? = nil
    //错误信息
    var errorMessage: String = ""
    //请求能否可以多个并行
    var canMultipleConCurrent : Bool = false
    //追加的cookies
    var addedCookies : NSMutableArray = NSMutableArray.init()
    //返回的状态码， 默认200成功
    var responseStatusCode : Int = 200
    //请求的错误
    var error : Error?
    //添加的数值
    var additionValues : NSMutableDictionary = NSMutableDictionary.init()
    
    func setup() {
        self.requestMethod = .post
    }
    
    init(cmdCode:E_CMDCODE = E_CMDCODE.CC_default, postDic:[String: Any]? = nil, delegate:HttpResponseDelegate? = nil) {
        setup()
        self.requestUrl = append(suffUrl: cmdCode)
        self.cmdCode = cmdCode
        self.delegate = delegate
        self.parame = postDic
    }
    
    public func cancelDelegate() -> Void {
        delegate = nil
    }
    func cancelDelegateAndCancel() -> Void {
        cancelDelegate()
        
    }
}
/*!
 @protocol       HttpResponseDelegate
 @abstract       HttpMessage的一个代理
 @discussion     代理模式
 */
protocol HttpResponseDelegate {
    /*!
     @method        receiveDidFinished
     @abstract      请求完成（请求有返回）后的回调方法
     @discussion    代理类中实现
     @param         receiveMsg  HttpMessage对象
     */
    func receiveDidFinished(receiveMsg:HttpMessage) -> Void;
    
}

