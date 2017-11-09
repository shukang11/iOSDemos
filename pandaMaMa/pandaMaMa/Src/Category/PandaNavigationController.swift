//
//  PandaNavigationController.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/21.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit

public extension UINavigationController {
    func setNavigationBackground(alpha: CGFloat) -> Void {
        if let barBackgroundView: UIView = self.navigationBar.subviews.first {
            if self.navigationBar.isTranslucent {//是否开启半透明效果
                if let backgroundImageView: UIImageView = barBackgroundView.subviews.first as? UIImageView  {
                    if backgroundImageView.image != nil {
                        barBackgroundView.alpha = alpha
                    }else {
                        barBackgroundView.subviews[1].alpha = alpha
                    }
                }else {
                    barBackgroundView.subviews[1].alpha = alpha
                }
            }else {
                barBackgroundView.alpha = alpha
            }
            if let shadowView = barBackgroundView.value(forKey: "_shadowView") as? UIView {
                shadowView.alpha = alpha
            }
        }
    }
}
