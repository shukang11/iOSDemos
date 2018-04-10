//
//  PaymentTool.swift
//  pandaMaMa
//
//  Created by tree on 2018/4/7.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
/**
 尝试通过工厂模式构建一个可拓展的支付逻辑
 */

// 两种商品类型对应不同的数据通道
public enum PayPipeType: Int {
    case unknow // 默认
    
    case common // 常规商品
    
    case virtual // 虚拟商品
    
}

public protocol PipeLine {// 支付通道(支付宝，微信等)
    // 所有想要支持工厂方法的对象，都需要实现此协议
    
}



public final class PaymentTool: NSObject {// 不可继承的类
    /**
     支付过程：
     1，经过支付前展示后，通过选择支付方式，返回不同的接口地址
     */
    
    public var paytype: PayPipeType = .unknow
    
    public override init() {
        super.init()
    }
}

class WechatPipe: PipeLine {
    
}

