//
//  APPConstant.swift
//  whereIsMyCar
//
//  Created by Mac on 16/11/18.
//  Copyright © 2016年 Blin. All rights reserved.
//

import Foundation
import UIKit
struct APPConstant {
    
    //MARK:Singlton
    static let userDefault:UserDefaults = UserDefaults.standard//NSUserDefault
    static let window:UIWindow = UIApplication.shared.keyWindow!//UIWindow
    
    
    //MARK:Constant
    static let bundleVersionKey:String = kCFBundleVersionKey as String
    static let appVersion:String? = UserDefaults.standard.object(forKey: kCFBundleVersionKey as String) as? String//app版本
    
    static let currentVersion:String = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String//版本号
    
    //MARK:aboutSize
    static let windowBounds:CGRect = (UIApplication.shared.keyWindow?.frame)!//窗口尺寸
    static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height// 状态栏高度
    
    //MARK:Strings
    static let AppName:String = {
        let info:[String:Any] = Bundle.main.infoDictionary!
        return info["CFBundleDisplayName"] as! String
    }()//app名字
    static let sqlitName:String = "/Record.sqlite"//数据库文件名
    static let tableName:String = "recordPosition"//表名
    
    
}

public let kBanner_scale: CGFloat = 300/750.0//banner的比例

public let kScreenWidth = APPConstant.windowBounds.size.width
public let kScreenHeight = APPConstant.windowBounds.size.height


public let kSpan_larger: CGFloat = 15.0//较大间距
public let kSpan_general: CGFloat = 10.0//一般间距
public let kSpan_small: CGFloat = 5.0//较小间距

//MARK:-
//MARK:日志模块
public func DLog<T>(_ message:T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent), \(method)[\(line)]---> \(message) \n")
    #endif
}




