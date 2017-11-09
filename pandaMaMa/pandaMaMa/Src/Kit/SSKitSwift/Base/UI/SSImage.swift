//
//  SSImage.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit
public extension UIImage {
    public func toColor() -> UIColor {
        return UIColor.init(patternImage: self)
    }
    
    /// 将一个图片进行裁剪
    ///
    /// - parameter image:   原图片
    /// - parameter cutRect: 裁剪的尺寸
    ///
    /// - returns: 返回的是一个图片
    public class func image(_ image: UIImage, cutRect: CGRect) -> UIImage {
        guard let sourceImageRef = image.cgImage else {
            return UIImage.init()
        }
        let newImageRef = sourceImageRef.cropping(to: cutRect)
        return UIImage.init(cgImage: newImageRef!)
    }
    
    public func base64String(limitQuality limit: CGFloat) -> String {
        var data:Data
        var imgString:String = ""
        if (limit >= 1) {
            data = (UIImagePNGRepresentation(self)?.base64EncodedData(options: Data.Base64EncodingOptions.lineLength64Characters))!
        }else if (limit <= 0) {
            data = UIImageJPEGRepresentation(self, 0.1)!
        }else {
            data = UIImageJPEGRepresentation(self, limit)!
        }
        imgString = data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return imgString
    }
}
