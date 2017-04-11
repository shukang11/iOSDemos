//
//  Cell.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/4/10.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

/// 继承于UITableViewCell，为框架中的基本cell，遵循了一些协议
open class BaseCell:UITableViewCell, BaseCellType {
    public var cellHeight: (() -> CGFloat)?


    public var baseRow: BaseCell! { return nil }
    
    public required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func configure() {}
    open func update() {}
    open func didSelect() {}
    
    public /// 获得当前的试图控制器
    func formHandlerViewController() -> UIViewController? {
        return nil
    }
    
    public /// 当cell注销第一响应者的时候调用
    func cellResignFirstResponder() -> Bool {
        return false
    }
    
    public /// 当cell成为第一响应者的时候调用
    func cellCanBecomeFirstResponder() -> Bool {
        return false
    }
}

open class Cell<T: Equatable>: BaseCell, TypedCellType {
    public typealias Value = T

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        height = { UITableViewAutomaticDimension }()
    }
    
    open override func configure() {
        super.configure()
    }
    
    open override func update() {
        super.update()
    }
    
    open override func didSelect() {
        super.didSelect()
    }
}
