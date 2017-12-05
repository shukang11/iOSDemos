//
//  HttpConstant.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/17.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

public func append(suffUrl: E_CMDCODE) -> String {
    return "\(kPort_script_URL + suffUrl.rawValue)"
}

public let kApp_Type = "2"//客户端类型1安卓 2ios

func devecieDict() -> [String: String] {
    return ["app_type": kApp_Type, "device_type": UIApplication.shared.modelName]
}

public func appendParams(params: [String: Any] = [:], carryDeviceInfo:Bool = true, carryUserInfo:Bool = true, encrypt: Bool=true) -> [String: Any] {
    var tempParams = params
    if carryUserInfo {
        if let userid = UserInfoCenter.default.token, let deviceId = UserInfoCenter.default.deviceId {
            tempParams["id"] = "\(userid)"
            tempParams["token"] = "\(deviceId)"
        }else {
            tempParams["area_code"] = "\(UserDefaults.standard.object(forKey: key_user_area_code) ?? "340104")"
        }
    }
    if carryDeviceInfo {
        for (_, dict) in devecieDict().enumerated() {
            tempParams[dict.key] = dict.value
        }
    }
    if encrypt == false { return tempParams }
    var encryptString = kEncript_code
    let sortedParams = tempParams.sorted(by: {$0.key < $1.key})
    for (_, val) in sortedParams {
        let value = val as AnyObject
        if value is String {
            encryptString = encryptString.appending("\(value)") }
        else if value is NSNumber {
            encryptString = encryptString.appending("\(value)")
        }
    }
    encryptString = encryptString.appending(kEncript_code)
    tempParams["verify"] = encryptString.md5String()
    return tempParams
}

public enum E_CMDCODE:String {
    case CC_default                         =   ""//默认
    case CC_login                           =   "/user/1"// 登录
}
//需要验证登录信息的接口(需要token)
public func CC_NEED_LOGIN_QUEUE() -> [E_CMDCODE] {
    return [.CC_login]
}
//需要重写cookie的接口
public func CC_NEED_COOKIE_QUEUE() -> [E_CMDCODE] {
    return []
}

//MARK: cookies
let HEADERS       = ["X-Requested-With": "XMLHttpRequest", "User-Agent": "transportClient"]

#if DEBUG
let kHost_baseURL = "http://127.0.0.1:5000/"
#else
let kHost_baseURL = "http://127.0.0.1:5000/"
#endif
let kHost_endpoint_URL = "api/v1000"//中间的url地址

let kPort_script_URL = kHost_baseURL + kHost_endpoint_URL


let kHttp_Notice_ReqesutFailed = "网络连接失败，请稍后重试"
let kHttp_Notice_LoadingText = "加载中..."
let kHttp_Notice_UploadingText = "上传中..."
let kHttp_Notice_VerifyText = "验证中..."
let kHttp_Notice_GettingText = "获取中..."
let kHttp_Notice_SendingText = "发送中..."
