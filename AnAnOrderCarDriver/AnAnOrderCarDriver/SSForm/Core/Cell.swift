//
//  Cell.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/4/10.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

open class BaseCell:UITableViewCell, BaseCellType {

    open func configure() {}
    open func update() {}
    open func didSelect() {}
}

open class Cell<T: Equatable>: BaseCell, TypedCellType {
    public typealias Value = T

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
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
