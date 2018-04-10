//
//  SettingPage.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/21.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit
class SettingPage: CommonViewController {
    //MARK:property
    
    //MARK:systemCycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        self.createUI()
        self.title = "设置-动画"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    //MARK:delegate&dataSource
    
    //MARK:customMethod
    private func createUI() {
        let button = UIButton.init(frame: view.bounds)
        button.backgroundColor = UIColor.red
        button.addBlock(controlEvents: .touchUpInside) { (sender) in
            self.navigationController?.pushViewController(SettingPage(), animated: true)
        }
        view.addSubview(button)
    }
}
