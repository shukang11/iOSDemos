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

class HomePage: CommonViewController,CommonServiceDelegate {
    //MARK:property属性
    let commonService: CommonService = CommonService.init()
    //MARK:system系统
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        self.commonService.delegate = self
        self.createMainUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    //MARK:delegate&dataSource代理和数据源
    
    func didReceiveNotice() {
        DLog("没有通知")
        self.hidHub()
    }
    
    func didFailureReceived() {
        
    }
    //MARK:customMethod自定义
    func createMainUI() {
        self.showDefaultHub(self.view, message: kHttp_Notice_LoadingText)
        self.commonService.beginGetNotice()
    }
}
