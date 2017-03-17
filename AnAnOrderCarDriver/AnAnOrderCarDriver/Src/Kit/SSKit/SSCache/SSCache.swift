//
//  SSCache.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/11/16.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit
import CoreFoundation
import QuartzCore
/// 存储管理
class SSCache : NSObject {
    public var name:String
    public var memoryCache:SSMemoryCache
    public var diskCache:SSDiskCache
    
    override init() {
        self.name = ""
        self.memoryCache = SSMemoryCache.init()
        self.diskCache = SSDiskCache.init()
        super.init()
    }
    
    init?(_ path:String) {
        if path.characters.count == 0 { return nil}
        self.memoryCache = SSMemoryCache.init()
        self.diskCache = SSDiskCache.init()
        self.name = ""
        super.init()
    }
}

/// 硬盘存储
class SSDiskCache: NSObject {
    override init() {
        super.init()
    }
    
    init(_ path:String) {
        
    }
    
    init(_path:String, threshold:UInt) {
        
    }
}


/// 内存存储
class SSMemoryCache: NSObject {
    
    //MARK:attr
    public var name:String?
    public var totalCount:UInt?
    public var totalCost:UInt?
    //MARK:Limit
    public var countLimit:UInt = UInt.max
    public var costLimit:UInt = UInt.max
    public var ageLimit:TimeInterval = DBL_MAX
    public var autoTrimInterval:TimeInterval = 5.0
    
    public var shouldRemoveAllObjectsOnMemoryWarning:Bool = true
    public var shouldRemoveAllObjectsWhenEnteringBackground:Bool = true
    
    public var didReceiveMemoryWarningBlock:((_ memoryCache:SSMemoryCache)->())?
    public var didEnterBackgroundBlock:((_ memory:SSMemoryCache)->())?
    
    
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(appDidReceiveMemoryWarningNotification), name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackgroundNotification), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    func appDidReceiveMemoryWarningNotification() {
        self.didReceiveMemoryWarningBlock!(self)
    }
    func appDidEnterBackgroundNotification() {
        self.didEnterBackgroundBlock!(self)
    }
}
