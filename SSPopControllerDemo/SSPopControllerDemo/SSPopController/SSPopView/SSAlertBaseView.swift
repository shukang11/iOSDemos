//
//  SSAlertBaseView.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/13.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SSAlertBaseViewDelegate {
    @objc func configure() ->Void
    
    @objc func updateLayouts() -> Void
}

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
    
    convenience init(title:String, style:SSAlertActionStyle, handler:@escaping Handler) {
        self.init()
        self.title = title
        self.style = style
        self.handler = handler
    }
}

private var myContext = 0
class SSAlertBaseView: UIView,SSAlertBaseViewDelegate {
    
    //MARK:-
    //MARK:properties
    var viewController:SSAlertController!
    var actions:[SSAlertAction] = []
    var title:String = ""
    var message:String = ""
    
    
    //MARK:-
    //MARK:lifeCycle
    convenience init(title:String, message:String, viewController:SSAlertController) {
        self.init()
        self.title = title
        self.message = message
        self.viewController = viewController
        self.addObserver(self, forKeyPath: "actions", options: .new, context: &myContext)
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "actions")
    }
    //MARK:-
    //MARK:delegate
    
    //MARK:-
    //MARK:helper
    @objc internal func configure() {
        for action in actions {
            print("\(action.title)")
        }
    }
    
    func updateLayouts() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK:-
    //MARK:KVC
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "actions" else {
            return
        }
        updateLayouts()
    }
}
