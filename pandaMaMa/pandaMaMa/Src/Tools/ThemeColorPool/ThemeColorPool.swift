//
//  ThemeColorPool.swift
//  pandaMaMa
//
//  Created by tree on 2018/4/7.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import UIKit


/// 创建的管理主题的工具(包括颜色，图片资源等)
class ThemeColorPool: NSObject {
    static let `shared` = ThemeColorPool()
    
    private override init() {
        super.init()
    }
}
