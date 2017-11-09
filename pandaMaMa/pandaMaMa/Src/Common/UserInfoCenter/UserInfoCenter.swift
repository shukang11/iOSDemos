//
//  UserInfoCenter.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/17.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit

class UserInfoCenter {
    
    static let `default` = UserInfoCenter()
    
    var filePath: String {
        let tempPath = NSHomeDirectory()
        return tempPath.appending("/Documents/userInfo.plist")
    }
    
    var fileIsExsist: Bool {
        let fileManager: FileManager = FileManager.default
        return fileManager.fileExists(atPath: filePath)
    }
    
    private init() {
        
    }
    
    func userInfo() -> NSDictionary? {
        return NSDictionary.init(contentsOfFile: filePath)
    }
    
    func update(userInfo: NSDictionary) {
        guard let userDict = NSMutableDictionary.init(contentsOfFile: filePath) else {
            userInfo.write(toFile: filePath, atomically: true)
            return
        }
        for (_, value) in userInfo.enumerated() {
            userDict.setValue(value.value, forKey: value.key as! String)
        }
        userDict.write(toFile: filePath, atomically: true)
    }
    
    func removeInfo() {
        guard fileIsExsist == true else { return }
        do {
            let fileManager: FileManager = FileManager.default
            try fileManager.removeItem(atPath: filePath)
        } catch _ as NSError { return }
    }
    
    var token: String? {//user's identifier
        guard let userDict = userInfo() else { return nil }
        return userDict.object(forKey: "id") as? String
    }
    
    var deviceId: String? {//device's token
        guard let userDict = userInfo() else { return nil }
        return userDict.object(forKey: "token") as? String
    }
}
