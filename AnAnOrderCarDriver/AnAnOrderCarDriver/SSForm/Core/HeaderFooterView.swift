//
//  HeaderFooterView.swift
//  AnAnOrderCarDriver
//
//  Created by tree on 2017/4/11.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit


public enum HeaderFooterProvider<ViewType: UIView> {
    
    case `class`
    
    case callback(() -> ViewType)
    
    case nibFile(name: String, bundle: Bundle?)
    
    internal func createView() -> ViewType {
        switch self {
        case .class:
            return ViewType()
        case .callback(let builder):
            return builder()
        case .nibFile(let nibName, let bundle):
            return (bundle ?? Bundle(for: ViewType.self)).loadNibNamed(nibName, owner: nil, options: nil)![0] as! ViewType
        }
    }
}

/// 代表区头和区尾的类型
public enum HeaderFooterType {
     case header, footer
}

/// 如果有视图跳转的动作，那么需要遵守这个协议
public protocol TypedRowControllerType:RowControllerType  {
    associatedtype RowValue: Equatable
    
    /// 跳转视图动作所属的row
    var row: RowOf<Self.RowValue>! { get set}
}

/// 区头区尾需要遵守的协议
public protocol protocolHeaderFooterViewRepresentable {
    
    func viewForSection(_ section: Section, type: HeaderFooterType) -> UIView?
    
    /// 如果以文字来初始化的，那么会将文字显示
    var title: String? { get set }
    
    /// 区头区尾的高度
    var height: (() -> CGFloat)? { get set }
}


public struct HeaderFooterView<ViewType: UIView> : protocolHeaderFooterViewRepresentable {

    public /// 如果以文字来初始化的，那么会将文字显示
    var title: String?

    
    public /// 区头区尾的高度
    var height: (() -> CGFloat)?


    public func viewForSection(_ section: Section, type: HeaderFooterType) -> UIView? {
        var view: ViewType?
        if type == .header {
            
        }else {
            
        }
        guard let v = view else { return nil }
        
    }

    
}
