//
//  CellType.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/4/10.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit
/// 针对cell的协议
public protocol BaseCellType: class {
    /// 单元格的高度，只读属性
    var cellHeight: (() -> CGFloat)? { get }
    
    /// 在初始化单元格后调用
    func configure()
    
    /// 更新的时候调用
    func update()
    
    /// 点击的时候调用
    func didSelect()
    
    /// 当cell成为第一响应者的时候调用
    func cellCanBecomeFirstResponder() -> Bool
    
    /// 当cell注销第一响应者的时候调用
    func cellResignFirstResponder() -> Bool
    
    /// 获得当前的试图控制器
    func formHandlerViewController() -> UIViewController?
}

/// 所有的cell都应该遵循这个协议，因为都需要有个Value值
public protocol TypedCellType: BaseCellType {
    associatedtype Value:Equatable
}

public protocol CellType: TypedCellType {}
