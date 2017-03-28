//
//  TransportPage.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/24.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit
class TransportPage: CommonViewController {
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
        formView = SSFormTableView.init(frame: CGRect.init(x: 0.0, y: 64.0, width: view.frame.size.width, height: view.frame.size.height - 64.0))
        view.addSubview(formView)
        let form = formView.form
        
        let section:SSFormSectionDescriptor = SSFormSectionDescriptor.init("")
        form?.addSection(section)
        for _ in 1...10 {
            let row :SSFormRowDescriptor = SSFormRowDescriptor.init(40.0, cellClassString: "SSFormSystemTextCell", value: ["title":"name","detailLabel":"detialLabel"] as AnyObject)
            section.add(row)
        }
    }
    
}
