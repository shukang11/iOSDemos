//
//  ModuleProtocols.swift
//  pandaMaMa
//
//  Created by tree on 2018/1/29.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

@objc public protocol HookModuleProtocol: UIApplicationDelegate, UNUserNotificationCenterDelegate where Self : NSObject {
    
}

@objc public protocol ModuleSingleton {
    static var singleton: ModuleSingleton { get }
}

