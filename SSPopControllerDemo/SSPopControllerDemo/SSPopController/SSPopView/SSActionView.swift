//
//  SSActionView.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/13.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit



class SSActionView: SSAlertBaseView {
    //MARK:-
    //MARK:properties
    
    
    private var titleLabel:UILabel = {
        return UILabel()
    }()
    private var messageLabel:UILabel = {
        return UILabel()
    }()
    
    //MARK:-
    //MARK:lifeCycle
    convenience init(title:String, message:String,viewController:SSAlertController) {
        self.init()
        self.title = title
        self.message = message
        self.viewController = viewController
        configure()
    }
    
    //MARK:-
    //MARK:helper
    
    
    //MARK:-
    //MARK:delegate
    
    //MARK:-
    //MARK:public
    override func configure() {
        super.configure()
        guard self.viewController != nil else {
            assert(1 != 1, "self.viewController can't be nil")
        }
        self.backgroundColor = UIColor.purple
        self.addSubview(titleLabel)
        self.addSubview(messageLabel)
    }
    
    override func updateLayouts() {
        super.updateLayouts()
        guard self.viewController != nil else {
            return
        }
        NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: alertWidth).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 100.0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.viewController.view, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.viewController.view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
    }
}
