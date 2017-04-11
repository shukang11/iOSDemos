//
//  Validation.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/4/11.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation

public struct ValidationError {
    public let msg: String
    
    public init(msg: String) {
        self.msg = msg
    }
}


/// 需要验证的协议
public protocol BaseRuleType {
    var id: String? { get set}
    
}

public protocol RuleType: BaseRuleType {
    associatedtype RowValueType
    
    func isValid(value: RowValueType?) -> ValidationError?
}
