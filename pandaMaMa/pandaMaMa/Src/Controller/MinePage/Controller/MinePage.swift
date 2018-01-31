//
//  MinePage.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/17.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit

class MinePage: CommonViewController {
    //MARK:property
    var tableData: [[String: Any]] = []
    
    //MARK:lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor()
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    //MARK:delegate&dataSource
    
    //MARK:customMethod
    private func createUI() {
        
        let button = UIButton.init(frame: view.bounds)
        button.backgroundColor = UIColor.orange
        button.addBlock(controlEvents: .touchUpInside) { (sender) in
            self.navigationController?.pushViewController(SettingPage(), animated: true)
        }
        view.addSubview(button)
        
    }
    
    private func prepareTableData() {
        var array: [[String: Any]] = []
        //个人信息行
        array.append({
            var sectionDict: [String: Any] = [:]
            var cellList:[Dictionary<String, Any>] = []
            cellList.append({
                let cellDict: [String: Any] = [kTableViewCellTypeKey:"User_", kTableViewCellHeightKey: HomeBannerCell.cellHeight()]
                return cellDict
                }())
            sectionDict[kTableViewNumberOfRowsKey] = cellList.count
            sectionDict[kTableViewCellListKey] = cellList
            return sectionDict
            }())
    }
}


