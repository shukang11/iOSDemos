//
//  Row.swift
//  AnAnOrderCarDriver
//
//  Created by tree on 2017/4/11.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation


open class RowOf<T: Equatable>: BaseRow {
    private var  _value: T? {
        didSet {
            guard _value != oldValue else { return }
            
        }
    }
    
    
}
