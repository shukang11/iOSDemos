//
//  SSApplication.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 17/1/20.
//  Copyright © 2017年 YD. All rights reserved.
//

import Foundation
import UIKit

let CFBundleShortVersionString:String = "CFBundleShortVersionString"
let CFBundleVersion:String = "CFBundleVersion"
let CFBundleDisplayName:String = "CFBundleDisplayName"
let CFBundleIdentifier:String = "CFBundleIdentifier"

extension UIApplication {
    var infoDictionary: Dictionary<String, Any> {
        get {
            return Bundle.main.infoDictionary!
        }
    }
    //设备的名称
    var deviceName: String {
        return UIDevice.current.name
    }
    
    /// 系统的名称 例如：xxx的iPhone
    var systemName: String {
        return UIDevice.current.systemName
    }
    
    /// 系统名称 例如：iPhone OS
    var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    
    /// 设备标识符
    var deviceUUID: String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    
    /// 设备的型号 例如：iPhone
    var deveiceModel: String {
        return UIDevice.current.model
    }
    
    /// 获取app的版本号
    var appVersion: String {
        return infoDictionary[CFBundleShortVersionString] as! String
    }
    
    /// 获取app的build版本号
    var appBuildVersion: String {
        return infoDictionary[CFBundleVersion] as! String
    }
    
    /// 获得app名字
    var appName: String {
        return infoDictionary[CFBundleDisplayName] as! String
    }
    
    /// 获得app的bundleID
    var bundleIdentifier: String {
        return infoDictionary[CFBundleIdentifier] as! String
    }
}
