//
//  SSAlertSystemView.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/15.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

private let padding:CGFloat = 15.0
private let buttonHeight:CGFloat = 50.0
private let titleHeight:CGFloat = 30.0
private let titleLabelFontSize:CGFloat = 15.0
private let messageLabelFontSize:CGFloat = 12.0

class SSAlertSystemView: SSAlertBaseView {
    //MARK:-
    //MARK:properties
    var titleLabel:UILabel!
    var messageLabel:UILabel!
    
    var buttons:[UIButton]?
    //MARK:-
    //MARK:public
    override func configure() {
        super.configure()
        titleLabel = UILabel.init()
        messageLabel = UILabel.init()
        titleLabel.text = title
        messageLabel.text = message
        for label in [titleLabel,messageLabel] {
            label?.textColor = UIColor.gray
            label?.textAlignment = .center
            label?.backgroundColor = UIColor.white
            label?.numberOfLines = 0
        }
        titleLabel.font = UIFont.systemFont(ofSize: titleLabelFontSize)
        messageLabel.font = UIFont.systemFont(ofSize: messageLabelFontSize)
        addSubview(titleLabel)
        addSubview(messageLabel)
    }
    
    override func addAction(action: SSAlertAction) {
        super.addAction(action: action)
        
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    override func setupSuperViewContranints() {
        super.setupSuperViewContranints()
        self.backgroundColor = UIColor.white
        self.maxHeight = padding
        if title != "" {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: titleLabel,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .leading,
                               multiplier: 1.0,
                               constant: 0.0).isActive = true
            
            NSLayoutConstraint(item: titleLabel,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .top,
                               multiplier: 1.0,
                               constant: self.maxHeight).isActive = true
            
            NSLayoutConstraint(item: titleLabel,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: 0.0).isActive = true
            let size = title.getSize(togolFont: UIFont.systemFont(ofSize: titleLabelFontSize), togolSize: CGSize.init(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude),breakMode: .byWordWrapping)
            NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: size.height).isActive = true
            self.maxHeight += size.height
        }
        if message != "" {
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: messageLabel,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .leading,
                               multiplier: 1.0,
                               constant: 0.0).isActive = true
            
            NSLayoutConstraint(item: messageLabel,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: titleLabel,
                               attribute: .bottom,
                               multiplier: 1.0,
                               constant: 0.0).isActive = true
            
            NSLayoutConstraint(item: messageLabel,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: 0.0).isActive = true
            let size = message.getSize(togolFont: UIFont.systemFont(ofSize: messageLabelFontSize), togolSize: CGSize.init(width: ScreenSize.width-2*padding, height: ScreenSize.height), breakMode: .byWordWrapping)
            NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: size.height).isActive = true
            print("\(size.height)\(size.width)")
            self.maxHeight += size.height
        }
        
        buttons?.removeAll()
        for action in actions {
            if action.style == .Cancel {
                appendCancelButton(action: action)
            }else if action.style == .Default {
                appendDefaultButton(action: action)
            }else if action.style == .Destructive {
                appendDestructiveButton(action: action)
            }
        }
        self.maxHeight += padding
        
        NSLayoutConstraint.init(item: self, attribute: .centerX, relatedBy: .equal, toItem: alertController?.view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .centerY, relatedBy: .equal, toItem: alertController?.view, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: ScreenSize.width-2*padding).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: self.maxHeight).isActive = true
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5.0
    }
    
    //MARK:-
    //MARK:helper
    func appendDefaultButton(action:SSAlertAction) -> Void {
        let appended:UIButton = UIButton.init(type: .custom)
        appended.frame = CGRect.init(x: 0.0, y: self.maxHeight, width: ScreenSize.width-2*padding, height: buttonHeight)
        appended.setTitle(action.title, for: .normal)
        appended.backgroundColor = UIColor.white
        appended.setTitleColor(UIColor.black, for: .normal)
        addSubview(appended)
        buttons?.append(appended)
        self.maxHeight += buttonHeight
    }
    
    func appendDestructiveButton(action:SSAlertAction) -> Void {
        let appended:UIButton = UIButton.init(type: .custom)
        appended.frame = CGRect.init(x: 0.0, y: self.maxHeight, width: ScreenSize.width-2*padding, height: buttonHeight)
        appended.setTitle(action.title, for: .normal)
        appended.backgroundColor = UIColor.white
        appended.setTitleColor(UIColor.black, for: .normal)
        addSubview(appended)
        buttons?.append(appended)
        self.maxHeight += buttonHeight
    }
    
    func appendCancelButton(action:SSAlertAction) -> Void {
        let appended:UIButton = UIButton.init(type: .custom)
        appended.frame = CGRect.init(x: 0.0, y: self.maxHeight, width: ScreenSize.width-2*padding, height: buttonHeight)
        appended.setTitle(action.title, for: .normal)
        appended.backgroundColor = UIColor.white
        appended.setTitleColor(UIColor.red, for: .normal)
        addSubview(appended)
        buttons?.append(appended)
        self.maxHeight += buttonHeight
    }
    
}
