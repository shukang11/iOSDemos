//
//  Config.swift
//  FindMyCar
//
//  Created by Mac on 17/3/17.
//  Copyright © 2017年 Blin. All rights reserved.
//

import Foundation
import UIKit

public let key_user_area_code = "com.company.firstopen.areacode"//地区码，备用的
public let key_device_token = "com.compay.app.device.token"//用户标识
public let key_userphone_current = "com.cmpany.app.currentphone"//最近设备的登录名
public let key_username_current = "com.company.app.usernamepassword"//用户名

public let kEncript_code = "pandamama.1.0"//参与数据传输加密

public let K_Code_GD_KEY = "121377efd1ae9f50c4a0af470cd005aa"//高德地图key

// 字号样式
private let k_Font_Style_One_key = "Level_One"
private let k_Font_Style_Two_key = "Level_Two"
private let k_Font_Style_Three_key = "Level_Three"

final class Config {
    //MARK:-
    //MARK:properties
    static let current:Config = Config()
    
    // 用户设置文件后缀目录
    private let configPathSuf:String =  "/Documents/userInfo.plist"
    // 字体字号样式目录
    private let styleConfigPath: String? = Bundle.main.path(forResource: "FontConfig", ofType: "plist")
    // 用户设置文件目录
    private var configPath: String {
        return NSHomeDirectory().appending(configPathSuf)
    }
    // 所有的样式(所有分辨率的)
    var styleConfigAllContent: NSDictionary? {
        get {
            guard let dict: NSDictionary = NSDictionary.init(contentsOfFile: styleConfigPath ?? "") else { return nil }
            return dict
        }
    }
    
    // 当前样式
    var fitStyleContent: NSDictionary? {// 根据当前的分辨率获得字号属性集合
        get {
            if let allContent: NSDictionary = styleConfigAllContent {
                let resolutionW = UIScreen.main.resolutionSize.width
                if fabs(resolutionW - 640.0) < 100 { // 按照One
                    return allContent[k_Font_Style_One_key] as? NSDictionary
                }else if fabs(resolutionW - 750.0) < 100 { // 按照Two
                    return allContent[k_Font_Style_Two_key] as? NSDictionary
                }else if resolutionW - 1000 > 0 { // 按照Three
                    return allContent[k_Font_Style_Three_key] as? NSDictionary
                }
                return allContent
            }
            return nil
        }
    }
    
    
    //MARK:-
    //MARK:lifeCycle
    private init() { }
    
    //MARK:-
    //MARK:private
    private func commonInit() {
        
    }
    
    private func fileAtPath() -> Bool {
        let manager:FileManager = FileManager.default
        if manager.fileExists(atPath: self.configPath) {
            return true
        }
        return false
    }
    //MARK:-
    //MARK:public
    public func getUserDictionary() -> NSDictionary {
        let path:String = self.configPath
        guard let dic:NSDictionary = NSDictionary.init(contentsOfFile: path) else {
            return NSDictionary.init()
        }
        return dic
    }
    
    //MARK:-
    //MARK:hepler
}
