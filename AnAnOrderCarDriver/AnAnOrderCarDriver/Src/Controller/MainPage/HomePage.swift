//
//  HomePage.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/24.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit
import Log
import NVActivityIndicatorView

class HomePage: CommonViewController {
    //MARK:property属性
    //MARK:system系统
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        self.createMainUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    //MARK:delegate&dataSource代理和数据源
    //MARK:customMethod自定义
    func createMainUI() {
        self.showDefaultHub(self.view, message: kHttp_Notice_LoadingText)
        HttpManager.postForResult(HttpManager.getUrl(url: kHttpRequest_findOegtNotification), params: HttpManager.getParams(sourceDic: [:], cmdCode: .CC_FindOegtNotification), successBlock: { (response) in
            self.hidHub()
            DLog("\(response)")
        }, requestFailBlock: { (fail) in
            self.hidHub()
            DLog(fail)
        }) { (connectFail) in
            self.hidHub()
            DLog(kHttp_Notice_ReqesutFailed)
        }
    }
}
