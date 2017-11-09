//
//  PD_Dictionary.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/23.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation

extension Dictionary {
    func stringValue(key: String, defaultValue:String = "") -> String {
        guard let dict: [String: AnyObject] = self as? [String : AnyObject] else { return defaultValue }
        guard let value: String = dict[key] as? String else { return defaultValue }
        return value
    }
    
    func floatValue(key: String, defaultValue: Float = 0.0) -> Float {
        guard let dict: [String: AnyObject] = self as? [String : AnyObject] else { return defaultValue }
        guard let value: Float = dict[key] as? Float else { return defaultValue }
        return value
    }
    
    func boolValue(key: String, defaultValue: Bool = false) -> Bool {
        guard let dict: [String: AnyObject] = self as? [String : AnyObject] else { return defaultValue }
        guard let value: Bool = dict[key] as? Bool else { return defaultValue }
        return value
    }
    
    func intValue(key: String, defaultValue: Int = 0) -> Int {
        guard let dict: [String: AnyObject] = self as? [String : AnyObject] else { return defaultValue }
        guard let value: Int = dict[key] as? Int else { return defaultValue }
        return value
    }
    
    func numberValue(key: String, defaultValue: NSNumber = NSNumber.init()) -> NSNumber {
        guard let dict: [String: AnyObject] = self as? [String : AnyObject] else { return defaultValue }
        guard let value: NSNumber = dict[key] as? NSNumber else { return defaultValue }
        return value
    }
}
