//
//  SSAlertView.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/13.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

let padding:CGFloat = 15.0          //间隙
let alertWidth:CGFloat = 270.0      //弹窗总宽度
let bottonHeiht:CGFloat = 40.0      //按钮高度
let containerWidth:CGFloat = alertWidth - 2*padding        //内容宽度

class SSAlertView: SSAlertBaseView {
    //MARK:-
    //MARK:properties
    private var titleLabel: UILabel = {
        return UILabel()
    }()
    private var messageLabel:UILabel = {
        return UILabel()
    }()
    //MARK:-
    //MARK:lifeCycle
    convenience init(title:String, message:String,viewCOntroller:SSAlertController) {
        self.init()
        self.title = title
        self.message = message
        self.viewController = viewController
        configure()
    }
    
    //MARK:-
    //MARK:helper
    
    //MARK:-
    //MARK:public
    override func configure() {
        super.configure()
        guard self.viewController != nil else {
            assert(1 != 1, "self.viewController can't be nil")
        }
        self.backgroundColor = UIColor.purple
        addSubview(titleLabel)
        addSubview(messageLabel)
        updateLayouts()
    }
    override func updateLayouts() {
        super.updateLayouts()
    }
}
