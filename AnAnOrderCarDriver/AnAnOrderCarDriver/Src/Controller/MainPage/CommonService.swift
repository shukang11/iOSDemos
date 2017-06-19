//
//  CommonService.swift
//  AnAnOrderCarDriver
//
//  Created by tree on 2017/6/18.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation

class CommonService: DataService {
    var hasNoticeMsg: HttpMessage?
    
    override init() {
        
        super.init()
    }
    
    public func beginGetNotice() -> Void {
        self.hasNoticeMsg = HttpMessage.init(url: kHost_Truck_Base_UTL+kHost_API_URL+kHttpRequest_findOegtNotification, postDic: [:], delegate: self, cmdCode: E_CMDCODE.CC_FindOegtNotification)
        self.hasNoticeMsg?.requestMethod = .post
        self.httpMsgCtrl.sendMessage(message: hasNoticeMsg!)
    }
    
    //MARK:-
    //MARK:serice back delegate
    override func receiveDidFinished(receiveMsg: HttpMessage) {
        DLog(receiveMsg.jsonItems)
    }

}
