//
//  Config.swift
//  FindMyCar
//
//  Created by Mac on 17/3/17.
//  Copyright © 2017年 Blin. All rights reserved.
//

import Foundation
import UIKit

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
        let dictionary = getUserDictionary()
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
    
    private func getUserDictionary() -> NSDictionary {
        let path:String = configPath()
        guard let dic:NSDictionary = NSDictionary.init(contentsOfFile: path) else {
            return NSDictionary.init()
        }
        return dic
    }
    //MARK:-
    //MARK:hepler
    private func configPath() -> String {
        let tempPath:String = NSHomeDirectory()
        let path:String = tempPath.appending(configPathSuf)
        return path
    }
}
