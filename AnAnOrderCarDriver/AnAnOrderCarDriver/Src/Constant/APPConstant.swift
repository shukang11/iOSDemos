//
//  APPConstant.swift
//  whereIsMyCar
//
//  Created by Mac on 16/11/18.
//  Copyright © 2016年 Blin. All rights reserved.
//

import Foundation
import UIKit
import Log
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
    static let contentBounds:CGRect = CGRect(x: APPConstant.windowBounds.origin.x, y: APPConstant.windowBounds.origin.y+64.0, width: APPConstant.windowBounds.size.width, height: APPConstant.windowBounds.size.height-64.0)//有导航条的时候的内容尺寸
    
    
    //MARK:Strings
    static let AppName:String = {
        let info:[String:Any] = Bundle.main.infoDictionary!
        return info["CFBundleDisplayName"] as! String
    }()//app名字
    static let sqlitName:String = "/Record.sqlite"//数据库文件名
    static let tableName:String = "recordPosition"//表名
    
    
}


//MARK:-
//MARK:自定义颜色
public let kColor_Blue = "1e90f0"
public let kCOlor_Green = "20d375"

public let kColor_Gray = "3c3c3c"
public let kColor_Back_Gray = "#EFEFEF"



//MARK:-
//MARK:日志模块
public func DLog<T>(_ message:T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent), \(method)[\(line)]---> \(message)")
    #endif
}
