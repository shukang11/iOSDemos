//
//  PD_Style.swift
//  pandaMaMa
//
//  Created by tree on 2017/9/9.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit
//MARK:-
//MARK:自定义颜色
public extension UIColor {
    class func red_font() -> UIColor {//红色
        return UIColor.color("#e93421")
    }
    class func gray_font() -> UIColor {//字体灰
        return UIColor.color("#666666")
    }
    class func black_font() -> UIColor {//字体黑
        return UIColor.color("#333333")
    }
    class func gray_line() -> UIColor {//分割线灰
        return UIColor.color("#e5e5e5")
    }
    class func purple_font() -> UIColor {//字体紫
        return UIColor.color("#990a89")
    }
    class func lightGray() -> UIColor {//淡灰色
        return UIColor.color("#F2F3FF")
    }
    class func creamyWhite() -> UIColor {//米白色
        return UIColor.color("#F6F4F1")
    }
}


public enum PDFont_Level: String {
    case NavigationTitleFont = "Navigation_Title_Font_Size"
    case TitleFont = "Default_Title_Font_Size"
    case BodyFont = "Default_Body_Font_Size"
    case LimitFont = "Default_Limit_Font_Size"
    case RemarkFont = "Default_Remark_Font_Size"
}

public extension UIFont {
    class func naviTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: scaleFontSize(.NavigationTitleFont, defaultFont: 19))
    }
    //标题字号
    class func titleFont() -> UIFont {
        return UIFont.systemFont(ofSize: scaleFontSize(.TitleFont, defaultFont: 17))
    }
    //正文字号
    class func bodyFont() -> UIFont {
        return UIFont.systemFont(ofSize: scaleFontSize(.BodyFont, defaultFont: 15))
    }
    //小正文字号
    class func limitFont() -> UIFont {
        return UIFont.systemFont(ofSize: scaleFontSize(.LimitFont, defaultFont: 13))
    }
    //标注字号
    class func markFont() -> UIFont {
        return UIFont.systemFont(ofSize: scaleFontSize(.RemarkFont, defaultFont: 11))
    }
}
private func scaleFontSize(_ fontLevel: PDFont_Level, defaultFont: CGFloat) -> CGFloat {
    let config = Config.current
    if let fit: NSDictionary = config.fitStyleContent {
        if let size: CGFloat = fit[fontLevel.rawValue] as? CGFloat {
            return ceil(size)
        }
    }
    if kScreenWidth <= 375 { return defaultFont }
    return defaultFont * 1.1
}
