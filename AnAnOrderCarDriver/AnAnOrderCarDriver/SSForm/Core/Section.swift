//
//  Section.swift
//  AnAnOrderCarDriver
//
//  Created by tree on 2017/4/11.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation

open class Section {
    
    public var tag: String?
    
    public init(_ initializer: (Section) -> Void) {
        initializer(self)
    }
    public init(_ header: String, _ initializer: (Section) -> Void = { _ in}) {
        initializer(self)
    }
}
