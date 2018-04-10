//
//  PD_Button.swift
//  pandaMaMa
//
//  Created by tree on 2018/3/30.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    class func button(title: String, target: Any?, selector:Selector?) -> UIButton {
        return UIButton.button(title: title, image: nil, selected: nil, target: target, selector: selector)
    }
    
    class func button(title: String?, image:UIImage?, selected: UIImage?, target: Any?, selector:Selector?) -> UIButton {
        return UIButton.button(title: title, titleColor: UIColor.black, image: image, selected: selected, target: target, selector: selector)
    }
    
    class func button(title: String?, titleColor: UIColor?, image:UIImage?, selected: UIImage?, target: Any?, selector:Selector?) -> UIButton {
        let o = UIButton.init(type: .custom)
        o.setTitle(title, for: .normal)
        o.setTitleColor(titleColor, for: .normal)
        o.setImage(image, for: .normal)
        o.setImage(selected, for: .selected)
        if let s = selector { o.addTarget(target, action: s, for: .touchUpInside) }
        return o
    }
}
