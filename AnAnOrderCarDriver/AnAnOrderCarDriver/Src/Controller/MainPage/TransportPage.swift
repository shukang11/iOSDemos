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
        formTable = SSFormTable.init(frame: CGRect.init(x: 0.0, y: 64.0, width: view.width, height: view.height-64.0), style: .plain)
        view.addSubview(formTable)

        let formHelper:SSFormTableViewSourceHelper = SSFormTableViewSourceHelper.init(formTable)
        
        let form:SSFormDescriptor = SSFormDescriptor.init("表格")
        var section:SSFormSectionDescriptor = SSFormSectionDescriptor.init("")
        form.addSection(section)
        for _ in 1...10 {
            let row :SSFormRowDescriptor = SSFormRowDescriptor.init(40.0, cellClass: demoCell.self, value: "111" as AnyObject)
            row.deleteAnimation = .left
            row.onClickHandle({ (rowDes) in
                rowDes.value = "112" as AnyObject
            })
            section.add(row)
        }
        section = SSFormSectionDescriptor.init("added")
        section.height = 60.0
        form.addSection(section)
        
        formHelper.form = form
        
        formTable.sourceHelper = formHelper
    }
}
