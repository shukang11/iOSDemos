//
//  HttpMessage.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/17.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation

enum SSRequestMethod {
    case post
    case get
    //post 数据流，非表单，文件流上传
    case stream
}
class HttpMessage : NSObject {
    //==>sending
    //发送的代码类型
    var cmdCode : E_CMDCODE = .CC_Default
    //请求超时
    var timeout : Float = 30.0
    //请求的地址
    var requestUrl : String = ""
    //请求的参数
    var postParame : NSDictionary = NSDictionary.init()
    //请求的方法
    var requestMethod : SSRequestMethod = .get
    //添加的用户信息(can be nil)
    var userInfo : AnyObject?
    //二进制流 e.g. 图片数据
    var postData : Data = Data.init()
    //能否传输图片
    var isUploadImage : Bool = false
    //请求回调
    var delegate : HttpResponseDelegate?
    
    
    //==>recieving
    //错误码
    var errorCode : String = ""
    //回应的字符
    var responseString : String = ""
    //返回的json数据
    var jsonItens : NSDictionary = NSDictionary.init()
    //请求能否可以多个并行
    var canMultipleConCurrent : Bool = false
    //追加的cookies
    var addedCookies : NSMutableArray = NSMutableArray.init()
    //返回的状态码
    var responseStatusCode : Int = 0
    //请求的错误
    var error : NSError = NSError.init()
    //添加的数值
    var additionValues : NSMutableDictionary = NSMutableDictionary.init()
    
    init(url:String, postDic:NSDictionary, cmdCode:E_CMDCODE) {
        super.init()
        self.requestUrl = url
        self.cmdCode = cmdCode
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
@objc protocol HttpResponseDelegate {
    /*!
     @method        receiveDidFinished
     @abstract      请求完成（请求有返回）后的回调方法
     @discussion    代理类中实现
     @param         receiveMsg  HttpMessage对象
     */
    @objc optional func receiveDidFinished(receiveMsg:HttpMessage) -> Void;
    /*!
     @method        receiveDidFailed
     @abstract      请求失败（超时，网络未链接等错误）后的回调方法
     @discussion    代理类中实现
     @param         receiveMsg  HttpMessage对象
     */
    @objc optional func receiveDidFailed(receiveMsg:HttpMessage) -> Void;
}
