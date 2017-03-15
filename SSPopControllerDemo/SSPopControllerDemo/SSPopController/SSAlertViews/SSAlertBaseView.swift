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
    
    var cancelAction:SSAlertAction?
    var actions:[SSAlertAction] = []
    var alertController:SSAlertController?
    //MARK:-
    //MARK:lifeCycle
    convenience init(title:String, message:String) {
        self.init()
        self.title = title
        self.message = message
        
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


extension String {
    /// 将字符串的占用大小计算出来并返回
    ///
    /// - Parameters:
    ///   - font: 字体大小，默认是12
    ///   - size: 限制宽高
    ///   - mode: 换行类型
    /// - Returns: 返回的字符串占用宽高
    func getSize(togolFont font:UIFont, togolSize size:CGSize, breakMode mode:NSLineBreakMode) -> CGSize {
        let string: NSString = self as NSString
        var result:CGSize = CGSize.zero
        if (string.responds(to: #selector(NSString.boundingRect(with:options:attributes:context:)))) {
            var attr:[String: Any] = [NSFontAttributeName : font]
            if (mode != NSLineBreakMode.byWordWrapping) {
                let paragraphStyle = NSMutableParagraphStyle.init()
                paragraphStyle.lineBreakMode = mode
                attr[NSParagraphStyleAttributeName] = paragraphStyle
            }
            let rect: CGRect = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attr , context: nil)
            result = rect.size
        }else {
            result = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).size
        }
        
        return result
    }
}
