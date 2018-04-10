//
//  SSTableViewController.swift
//  pandaMaMa
//
//  Created by tree on 2018/3/30.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import UIKit

// 继承于SYViewController ，同时实现了TableView拓展协议
class SYTableViewController: CommonViewController, TableExtAble {
    //MARK:property
    var tableData: TableViewConvertTable = TableViewConvertTable()
    //MARK:systemCycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        super.viewDidLoad()
    }
    //MARK:delegate&dataSource
    
    //MARK:customMethod
    
}
