//
//  Config.swift
//  FindMyCar
//
//  Created by Mac on 17/3/17.
//  Copyright © 2017年 Blin. All rights reserved.
//

import Foundation
import UIKit

/**
 simg       学员头像图片地址
 sid        学号
 name       姓名
 idcard     身份证号
 sex        性别
 age        年龄
 mobile     手机
 adr        住址
 token      凭证
 xueshi     学时
 isdate     时间参数?
 */
private let dic_token = "token"//token

final class Config: NSObject {
    //MARK:-
    //MARK:properties
    static let current:Config = Config()
    
    private let configPathSuf:String = {
        return "/Documents/userInfo.plist"
    }()
    
    var fontSize: CGFloat = 16.0//字号
    var fontColor: String = ""//字体颜色
    
    //MARK:-
    //MARK:lifeCycle
    private override init() {
        super.init()
        let dictionary:NSDictionary = getUserDictionary()
        print("\(dictionary)")
    }
    
    //MARK:-
    //MARK:private
    private func fileAtPath() -> Bool {
        let manager:FileManager = FileManager.default
        if manager.fileExists(atPath: configPath()) {
            return true
        }
        return false
    }
    //MARK:-
    //MARK:public
    public func getUserDictionary() -> NSDictionary {
        let path:String = configPath()
        guard let dic:NSDictionary = NSDictionary.init(contentsOfFile: path) else {
            return NSDictionary.init()
        }
        return dic
    }
    
    public func getToken() -> String {
        let dic: NSDictionary = getUserDictionary()
        guard let token:String = dic.object(forKey: dic_token) as! String? else {
            return ""
        }
        return token
    }
    //MARK:-
    //MARK:hepler
    private func configPath() -> String {
        let tempPath:String = NSHomeDirectory()
        let path:String = tempPath.appending(configPathSuf)
        return path
    }
}
