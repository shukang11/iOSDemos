//
//  SSError.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/9/22.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation

public enum SSError: Error {
    case invalidURL(url: URLConvertible)
}
