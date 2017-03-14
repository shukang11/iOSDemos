//
//  SSAlertBaseView.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/14.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

public enum SSAlertActionStyle {
    case Default
    case Cancel
    case Destructive
}

typealias Handler = () -> Void

class SSAlertAction: NSObject {
    
    var title:String = ""
    var style:SSAlertActionStyle = .Default
    var handler:Handler?
    
    convenience init(title: String, style: SSAlertActionStyle,handler: Handler?) {
        self.init()
        self.title = title
        self.style = style
        self.handler = handler
    }
}

class SSAlertBaseView: UIView {
    //MARK:-
    //MARK:properties
    var maxHeight:CGFloat = 0.0
    
    var title:String = ""
    var message:String = ""
    
    var actions:[SSAlertAction] = []
    var alertController:SSAlertController?
    //MARK:-
    //MARK:lifeCycle
    convenience init(title:String, message:String) {
        self.init()
        self.title = title
        self.message = message
        self.backgroundColor = UIColor.red
        
        configure()
    }
    //MARK:-
    //MARK:public
    func configure() -> Void {
        
    }
    func addAction(action:SSAlertAction) -> Void {
        actions.append(action)
    }
    
    func setupSuperViewContranints() -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    //MARK:-
    //MARK:helper
}
