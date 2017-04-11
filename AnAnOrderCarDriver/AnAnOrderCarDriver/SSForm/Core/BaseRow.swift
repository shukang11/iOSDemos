//
//  BaseRow.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/4/10.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit
open class BaseRow: BaseRowType {
    var callbackOnChange: (() -> Void)?
    var callbackCellUpdate:(() -> Void)?
    var callbackCellSetup: Any?
    var callbackCellOnSelection: (() -> Void)?
    var callbackOnExpandInlineRow: Any?
    var callbackOnCollapseInlineRow: Any?
    var callbackOnCellHighlightChanged: (() -> Void)?
    var callbackOnRowValidationChanged: (() -> Void)?
    var _inlineRow: BaseRow?
    
    public internal(set) var wasChanged = false
    public internal(set) var wasBlurred = false
    public var tag: String?
    
    /// 点击的时候调用
    public func didSelect() {
        
    }
    
    /// 重绘的时候调用
    public func updateCell() {
        
    }
    
    /// cell的title属性
    public var title: String?
    
    /// cell的style属性
    public var cellStyle: UITableViewCellStyle = UITableViewCellStyle.value1
    
    /// row对应的cell
    public var baseCell: BaseCell! { return nil}
    
}
