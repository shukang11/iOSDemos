//
//  IndustryPage.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/17.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit

class IndustryPage: CommonViewController {//问行业
    //MARK:property
    
    //MARK:systemCycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.createUI()
    }
    //MARK:delegate&dataSource
    
    //MARK:customMethod
    private func createUI() {
        
    }
}
