//
//  hookModule.swift
//  pandaMaMa
//
//  Created by tree on 2018/1/29.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import UIKit

class swiftObj: NSObject {
    var templateName: String = "23333"
}

class hookModule: NSObject, ModuleSingleton, HookModuleProtocol {
    static var singleton: ModuleSingleton = hookModule()
    
    var templateName: String = "first inilizer"
    private override init() {
        
    }
    public func call() -> Void {
        print("\(templateName)")
    }
    
}
