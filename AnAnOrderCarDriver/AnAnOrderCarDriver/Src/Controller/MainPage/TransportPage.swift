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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    //MARK:delegate&dataSource代理和数据源
    //MARK:customMethod自定义
    func createMainUI() {
        formTable = SSFormTable.init(frame: CGRect.init(x: 0.0, y: 64.0, width: view.width, height: view.height-64.0-50.0), style: .plain)
        view.addSubview(formTable)
        let formHelper:SSFormTableViewSourceHelper = SSFormTableViewSourceHelper.init(formTable)
        
        let form:SSFormDescriptor = SSFormDescriptor.init("表格")
        let section:SSFormSectionDescriptor = SSFormSectionDescriptor.init("")
        form.addSection(section)
        for index in 1...2 {
            let row :SSFormRowDescriptor = SSFormRowDescriptor.init(40.0, cellClass: demoCell.self, value: "\(index)行----->点击我刷新当前行" as AnyObject)
            
            let action:UITableViewRowAction = UITableViewRowAction.init(style: .default, title: "添加", handler:{
            (action, indexPath) in
                print("added")
            })
            
            let ac:UITableViewRowAction = UITableViewRowAction.init(style: .default, title: "删除", handler:{
                (action, indexPath) in
                print("delete")
            })
            row.canEditRow = true
            row.editActions = [action,ac]
//            row.editingStyleHandle({ (rowDes, style, indexPath) in
//                if style != .insert { return}
//                let section:SSFormSectionDescriptor = SSFormSectionDescriptor.init("added-->\(indexPath)")
//                section.height = 40.0
//                section.insertAnimation = .none
//                formHelper.form.addSection(section)
//            })
            row.deleteAnimation = .left
            row.onClickHandle({ (rowDes, indexPath) in
                rowDes.value = "ssdfasldkjasdklfj" as AnyObject
            })
            section.add(row)
        }
        
        formHelper.form = form
        formTable.sourceHelper = formHelper
        
    }
}
