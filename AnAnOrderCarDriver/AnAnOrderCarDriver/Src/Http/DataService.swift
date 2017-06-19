//
//  DataService.swift
//  AnAnOrderCarDriver
//
//  Created by tree on 2017/6/18.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation

/// 用于请求网络信息的类，同时用来处理网络的回调，这之后才会分发给子类处理
/// 本身自己不会持有代理，但是子类必须设置httpMsgCtrl的代理，这样父类就可以实现了
public class DataService: HttpResponseDelegate {
    let httpMsgCtrl : HttpMsgCtrl;
    
    init() {
        self.httpMsgCtrl = HttpMsgCtrl.sharedCtrl;
    }
    
    //MARK:-
    //MARK:delegete
    func receiveDidFinished(receiveMsg: HttpMessage) {
        DLog(receiveMsg.jsonItems)
    }

    func receiveDidFailed(receiveMsg: HttpMessage) {
        
    }
}
