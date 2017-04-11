//
//  RowType.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/4/10.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit
/// cell需要一个tag
public protocol Taggable: AnyObject {
    var tag: String? {get set}
}

/// 本协议针对cell有一个tag
public protocol BaseRowType: Taggable {
    /// row对应的cell
    var baseCell: BaseCell! { get}
    
    /// cell的style属性
    var cellStyle: UITableViewCellStyle { get set}
    
    /// cell的title属性
    var title: String? { get set}
    
    /// 重绘的时候调用
    func updateCell()
    
    /// 点击的时候调用
    func didSelect()
    
}

public protocol TypeRowType: BaseRowType {
    associatedtype Cell: BaseCell, TypedCellType
    
    /// row对应的cell
    var cell: Cell! { get}
    
    /// row对应的值
    var value:Cell.Value? { get set}
    
    func add<Rule: RuleType>(rule: Rule) where Rule.RowValueType == Cell.Value
    
    func remove(ruleWithIdentifier: String)
}

/// 每个row都要遵循此协议
public protocol RowType: TypeRowType {
    init(_ tag: String?, _ initializer: (Self) -> Void)
}

extension RowType where Self: BaseRow {
    
    /// 默认的初始化方法
    public init(_ tag: String? = nil, _ initializer: (Self) -> Void = { _ in }) {
        self.init(tag)
        RowDefaults.rowInitialization["\(type(of: self))"]?(self)
        initializer(self)
    }
}

extension RowType where Self: BaseRow {
    /// 当cell更新的时候会调用
    public static var defaultCellUpdate: ((Cell, Self) -> Void)? {
        set {
            if let newValue = newValue {
                let wrapper: (BaseCell, BaseRow) ->  Void = { (baseCell: BaseCell, baseRow: BaseRow) in
                    newValue(baseCell as! Cell, baseRow as! Self)
                }
                RowDefaults.cellUpdate["\(self)"] = wrapper
                RowDefaults.rawCellUpdate["\(self)"] = newValue
            }else {
                RowDefaults.cellUpdate["\(self)"] = nil
                RowDefaults.rawCellUpdate["\(self)"] = nil
            }
        }
        
        get {
            return RowDefaults.rawCellUpdate["\(self)"] as? ((Cell, Self) -> Void)
        }
    }
    
    /// 当cell创建的时候会调用
    public static var defaultCellSetup: ((Cell, Self) -> Void)? {
        set {
            if let newValue = newValue {
                let wrapper: (BaseCell, BaseRow) -> Void = { (baseCell: BaseCell, baseRow:BaseRow) in
                    newValue(baseCell as! Cell, baseRow as! Self)
                }
                RowDefaults.cellSetup["\(self)"] = wrapper
                RowDefaults.rawCellSetup["\(self)"] = newValue
            }else {
                RowDefaults.cellSetup["\(self)"] = nil
                RowDefaults.rawCellSetup["\(self)"] = nil
            }
        }
        get {
            return RowDefaults.rawCellSetup["\(self)"] as?  ((Cell, Self) -> Void)
        }
    }
    
    /// 当cell成为第一响应者的时候会调用
    public static var defaultCellHighlightChanged:((Cell, Self) -> Void)? {
        set {
            if let newValue = newValue {
                let wrapper: (BaseCell, BaseRow) -> Void = { (baseCell: BaseCell, baseRow: BaseRow) in
                    newValue(baseCell as! Cell, baseRow as! Self)
                }
                RowDefaults.onCellHighlightChange["\(self)"] = wrapper
                RowDefaults.rawOnCellHighlightChanged["\(self)"] = newValue
            }else {
                RowDefaults.onCellHighlightChange["\(self)"] = nil
                RowDefaults.rawOnCellHighlightChanged["\(self)"] = nil
            }
        }
        get {
            return RowDefaults.rawOnCellHighlightChanged["\(self)"] as? ((Cell, Self) -> Void)
        }
    }
    
    /// 当row初始化的时候调用
    public static var defaultRowInitializer:((Self) -> Void)? {
        set {
            if let newValue = newValue {
                let wrapper: (BaseRow) -> Void = { (baseRow: BaseRow) in
                    newValue(baseRow as! Self)
                }
                RowDefaults.rowInitialization["\(self)"] = wrapper
                RowDefaults.rawRowInitialization["\(self)"] = newValue
            }else {
                RowDefaults.rowInitialization["\(self)"] = nil
                RowDefaults.rawRowInitialization["\(self)"] = nil
            }
        }
        get {
            return RowDefaults.rawRowInitialization["\(self)"] as? ((Self) -> Void)
        }
    }
    
    /// 在row初始化的时候会调用
    public static var defaultOnRowValidationChanged:((Cell, Self) -> Void)? {
        set {
            if let newValue = newValue {
                let wrapper: (BaseCell, BaseRow) -> Void = { (baseCell: BaseCell, baseRow: BaseRow) in
                    newValue(baseCell as! Cell, baseRow as! Self)
                }
                RowDefaults.onRowValidationChanged["\(self)"] = wrapper
                RowDefaults.rawOnRowValidationChanged["\(self)"] = newValue
            }else {
                RowDefaults.onRowValidationChanged["\(self)"] = nil
                RowDefaults.rawOnRowValidationChanged["\(self)"] = nil
            }
        }
        get {
            return RowDefaults.rawOnRowValidationChanged["\(self)"] as? ((Cell, Self) -> Void)
        }
    }
    
    /// 设置一个在row改变的时候会调用的回调
    ///
    /// - Returns: 这个row
    @discardableResult
    public func onChange(_ callBack: @escaping (Self) -> Void) -> Self {
        callbackOnChange = { [unowned self] in callBack(self) }
        return self
    }
    
    /// 设置一个在row对应的cell刷新的时候调用的回调
    ///
    /// - Returns: 这个row
    @discardableResult
    public func cellUpdate(_ callBack: @escaping ((_ cell: Cell, _ row: Self) -> Void)) -> Self {
        callbackCellUpdate = { [unowned self] in callBack(self.cell, self) }
        return self
    }
    
    /// 设置一个在cell创建的时候调用的回调
    ///
    /// - Returns: 这个row
    @discardableResult
    public func cellSetup(_ callBack: @escaping ((_ cell: Cell, _ row: Self) -> Void)) -> Self {
        callbackCellSetup = { [unowned self] (cell: Cell) in callBack(cell, self)}
        return self
    }
    
    /// 设置一个在cell被选中的时候调用的回调
    ///
    /// - Returns: 这个row
    @discardableResult
    public func onCellSelection(_ callBack: @escaping ((_ cell: Cell, _ row: Self) -> Void)) -> Self {
        callbackCellOnSelection = { [unowned self] in callBack(self.cell, self) }
        return self
    }
    
    /// 设置一个在cell成为第一响应者的时候调用的回调
    ///
    /// - Returns: 这个row
    @discardableResult
    public func onCellHighlightChange(_ callBack: @escaping((_ cell: Cell, _ row: Self) -> Void)) -> Self {
        callbackOnCellHighlightChanged = { [unowned self] in callBack(self.cell, self) }
        return self
    }
    
    /// 在（批准/确认/生效）改变的时候调用的回调
    ///
    /// - Returns: 这个row
    @discardableResult
    public func onRowValidationChange(_ callBack: @escaping (_ cell: Cell, _ row: Self) -> Void) -> Self {
        callbackOnRowValidationChanged = { [unowned self] in callBack(self.cell, self) }
        return self
    }
}
