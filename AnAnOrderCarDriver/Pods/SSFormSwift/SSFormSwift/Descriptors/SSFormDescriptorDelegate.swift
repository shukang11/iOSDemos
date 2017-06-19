//
//  SSFormDescriptorDelegate.swift
//  SSFormSwiftDemo
//
//  Created by Mac on 17/3/7.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

public protocol SSFormDescriptorDelegate {
    
    /// 将区移除的代理方法
    ///
    /// - Parameters:
    ///   - formSection: 区
    ///   - index: 区的索引
    /// - Returns: void
    func formSectionHasBeenRemoved(_ formSection:SSFormSectionDescriptor, At index:Int) -> Void
    
    /// 根据索引添加一个区
    ///
    /// - Parameters:
    ///   - formSection: 区
    ///   - index: 添加的位置
    /// - Returns: void
    func formSectionHasBeenAdded(_ formSection:SSFormSectionDescriptor, At index:Int) -> Void
    
    /// 单元格被添加
    ///
    /// - Parameters:
    ///   - formRow: 单元格描述对象
    ///   - indexPath: indexPath
    /// - Returns: void
    func formRowHasBeenAdded(_ formRow:SSFormRowDescriptor, At indexPath:IndexPath) -> Void
    
    /// 单元格被刷新
    ///
    /// - Parameters:
    ///   - formRow: 单元格的描述对象
    ///   - indexPath: indexpath
    /// - Returns: void
    func formRowHasBeenRemoced(_ formRow:SSFormRowDescriptor, At indexPath:IndexPath) -> Void
    
    /// 单元格改变了值得代理方法
    ///
    /// - Parameters:
    ///   - formRow: 单元格的描述对象
    ///   - oldValue: old值
    ///   - newValue: new值
    /// - Returns: void
    func formRowDescriptorValueHasChanged(_ formRow:SSFormRowDescriptor, newValue:AnyObject) -> Void
    
}
