//
//  HomeService.swift
//  pandaMaMa
//
//  Created by tree on 2017/7/5.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
@objc protocol HomeServiceDelegate {
    /// 获得首页轮播图信息
    @objc optional func didGetBannerInfo(dictionary: AnyObject?, isSuccess:Bool, responseObject:[String: Any]?) -> Void
    
    /// 首页跨境专区&爆款热卖&新品发布
    @objc optional func didGetGoodBannerInfo(dictionary: AnyObject?, isSuccess:Bool, responseObject:[String: Any]?) -> Void
}

public class HomeService: DataService {
    var delegate: HomeServiceDelegate?
    var bannerMsg : HttpMessage = HttpMessage.init()
    
    public func getBannerInfo() -> Void {
        var params = appendParams()
        params["username"] = "18356289815"
        params["password"] = "123456"
        let msg = HttpMessage.init(url: .CC_login, postDic: params, delegate: self, cmdCode: .CC_login)
        self.httpMsgCtrl.sendMessage(message: msg)
    }
    
    
    override func receiveDidFinished(receiveMsg: HttpMessage) {
        super.receiveDidFinished(receiveMsg: receiveMsg)
        var success = false
        if receiveMsg.cmdCode == .CC_login {
            if receiveMsg.responseStatusCode == 1 { success = true }
            self.delegate?.didGetBannerInfo?(dictionary: receiveMsg.bodyObject, isSuccess: success, responseObject: receiveMsg.json)
        }
        
    }
}

