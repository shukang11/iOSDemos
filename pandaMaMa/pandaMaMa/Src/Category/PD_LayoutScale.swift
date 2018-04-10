//
//  PD_LayoutScale.swift
//  pandaMaMa
//
//  Created by tree on 2018/4/7.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import UIKit
fileprivate var desingedStand: Float = 750.0
protocol LayoutScale {
    
    /// 根据设计稿转化长度的方法
    ///
    /// - Returns: 经过缩放的长度
    func pd_scale() -> Float
    
}
extension Int: LayoutScale {
    func pd_scale() -> Float {
        return (Float(UIApplication.shared.keyWindow?.frame.width ?? 0.0)*((Float(self))/desingedStand))
    }
}

extension CGFloat: LayoutScale {
    func pd_scale() -> Float {
        return (Float(UIApplication.shared.keyWindow?.frame.width ?? 0.0) * Float(self)/desingedStand)
    }
}

extension Float: LayoutScale {
    func pd_scale() -> Float {
        return (Float(UIApplication.shared.keyWindow?.frame.width ?? 0.0) * self/desingedStand)
    }
}
