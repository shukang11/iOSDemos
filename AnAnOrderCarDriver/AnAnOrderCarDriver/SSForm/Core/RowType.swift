//
//  RowType.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/4/10.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation



public protocol Taggable: AnyObject {
    var tag: String? {get set}
}

public protocol BaseRowType: Taggable {
    
}