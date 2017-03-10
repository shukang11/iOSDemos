//
//  SSAlertAction.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/10.
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
    var title: String = ""
    var style:SSAlertActionStyle = .Default
    var handler:Handler?
    
    internal convenience init(_ title:String, style:SSAlertActionStyle,handler:@escaping Handler) {
        self.init()
        self.title = title
        self.handler = handler
        self.style = style
    }
}
