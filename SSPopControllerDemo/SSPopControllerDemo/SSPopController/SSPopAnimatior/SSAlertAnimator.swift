//
//  SSAlertAnimator.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/10.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

public enum SSAlertPresentAnimatorType {
    case system                 // 系统样式
    case fadeIn                 //渐入
    case bounce                 //弹出
    case expandHorizontal       //水平展开
    case expandVertical         //垂直展开
    case slideDown              //从上往下划入
    case slideUp                //从下往上划入
    case slideLeft              //从右往左划入
    case slideRight             //从左往右划入
}

public enum SSAlertDismissAnimatorType {
    case fadeOut             // 渐出
    case contractHorizontal  // 水平收起
    case contractVertical    // 垂直收起
    case slideDown           // 向下划出
    case slideUp             // 向上划出
    case slideLeft           // 向左划出
    case slideRight          // 向右划出
}
