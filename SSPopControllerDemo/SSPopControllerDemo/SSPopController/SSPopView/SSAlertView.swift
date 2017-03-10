//
//  SSAlertView.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/10.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

class SSAlertView: UIView {
    
    //MARK:-
    //MARK:properties
    let defaultHeight:CGFloat = ScreenSize.height
    let defaultHeadViewHeight:CGFloat = 50.0
    let defaultLabelHeight:CGFloat = 20.0
    let defaultLabelPadding:CGFloat = 20.0
    let defaultLabelToPadding:CGFloat = 15.0
    
    
    var title:String = ""
    var message:String = ""
    
    
    //MARK:-
    //MARK:lifeCycle
    convenience init(_ title:String, message:String) {
        self.init()
        self.title = title
        self.message = message
        setupView()
    }
    
    //MARK:-
    //MARK:private
    private func setupView() -> Void {
        initialize()
    }
    
    private func initialize() {
        backgroundColor = UIColor.clear
        frame = CGRect.init(x: 0.0, y: ScreenSize.height-defaultHeight, width: ScreenSize.width, height: defaultHeight)
        
    }
    //MARK:-
    //MARK:public
    
    //MARK:-
    //MARK:delegate
    
}
