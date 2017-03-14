//
//  SSActionView.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/14.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

private let padding:CGFloat = 15.0
private let buttonHeight:CGFloat = 50.0
private let titleHeight:CGFloat = 40.0
class SSActionView: SSAlertBaseView {
    //MARK:-
    //MARK:properties
    var titleLabel:UILabel!
    var messageLabel:UILabel!
    //MARK:-
    //MARK:public
    override func configure() {
        super.configure()
        self.maxHeight = padding
        titleLabel = UILabel.init()
        messageLabel = UILabel.init()
        addSubview(titleLabel)
        addSubview(messageLabel)
        if title != "" {
            self.maxHeight += titleHeight
        }
        if message != "" {
            self.maxHeight += titleHeight
        }
        //setupHeadViewContranints()
    }
    
    override func addAction(action: SSAlertAction) {
        super.addAction(action: action)
    }
    
    override func setupSuperViewContranints() {
        super.setupSuperViewContranints()
        NSLayoutConstraint.init(item: self, attribute: .centerX, relatedBy: .equal, toItem: alertController?.view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: alertController?.view, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: ScreenSize.width).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: self.maxHeight).isActive = true
    }
    
    //MARK:-
    //MARK:helper
    func setupHeadViewContranints() -> Void {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.init(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: padding).isActive = true
        NSLayoutConstraint.init(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -padding).isActive = true
        NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: titleHeight).isActive = true
        NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 0.0, constant: padding).isActive = true
        
        NSLayoutConstraint.init(item: messageLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.init(item: messageLabel, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.init(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.init(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: titleHeight).isActive = true
    }
}
