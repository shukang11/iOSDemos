//
//  HelperTypes.swift
//  AnAnOrderCarDriver
//
//  Created by tree on 2017/4/11.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

/// 点击单元格跳转视图动作需要遵守的基本的协议
public protocol RowControllerType: NSObjectProtocol {
    
    /// 当视图控制器消失的时候调用的闭包
    var onDissmissCallback: ((UIViewController) -> Void) { get set }
}
