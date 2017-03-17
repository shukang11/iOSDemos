//
//  SSWebImageView.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/10/24.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit

typealias imageDnownloadComplete = ((_ image:UIImage, _ data:Data)->())?
extension UIImageView {
    /*
     下载
     
     本地存储管理
     
     内存存储管理
     */
    
    /// 为相册设置一个网络上的图片
    ///
    /// - parameter url: 网络资源的路径
    func ss_setImage(_ url:URL) {
        self.ss_setImage(url, placeHolderImage: nil, complete: nil)
    }
    
    /// 为相册设置一个网络上的图片
    ///
    /// - parameter url:              网络资源的路径
    /// - parameter placeHolderImage: 如果网络路径无法访问或者无法获得，那么将此图片显示出来
    func ss_setImage(_ url:URL, placeHolderImage:UIImage?,complete:imageDnownloadComplete) {

        guard let data = NSData.init(contentsOf: URL.init(fileURLWithPath: Path.caches.path+Path.separator+"sscaches/"+url.absoluteString.md5)) else {
            print("failure")
            return
        }
        self.image = UIImage.init(data: data as Data)
//        let request = URLRequest.init(url: url)
//        let dow = SSURLDownload()
//        dow.download(request)
        
        
    }
    
    
}
