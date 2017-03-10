//
//  SSDemoPage.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/9.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

class SSDemoPage: UIViewController {
    //MARK:property属性
    
    //MARK:system系统
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.orange
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
        
    }
    
}
