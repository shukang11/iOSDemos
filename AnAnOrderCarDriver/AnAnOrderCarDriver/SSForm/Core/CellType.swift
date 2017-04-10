//
//  CellType.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/4/10.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation

public protocol BaseCellType: class {
    
    /// 在初始化单元格后调用
    func configure()
    
    /// 更新的时候调用
    func update()
    
    /// 点击的时候调用
    func didSelect()
}

public protocol TypedCellType: BaseCellType {
    associatedtype Value:Equatable
}

public protocol CellType: TypedCellType {}
