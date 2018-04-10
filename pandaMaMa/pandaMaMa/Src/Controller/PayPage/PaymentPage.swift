//
//  PaymentPage.swift
//  pandaMaMa
//
//  Created by tree on 2018/4/7.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation

import UIKit
class PaymentPage: SYTableViewController {
    //MARK:property
    var factory: PaymentTool = PaymentTool()
    //MARK:systemCycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        super.viewDidLoad()
        self.createUI()
    }
    //MARK:delegate&dataSource
    
    //MARK:customMethod
    private func createUI() {
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.topMargin)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
