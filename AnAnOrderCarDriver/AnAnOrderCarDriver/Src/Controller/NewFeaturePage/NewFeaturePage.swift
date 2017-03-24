//
//  NewFeaturePage.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/24.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

let kIndexOfNewFeaturePage = 4
class NewFeaturePage: UIViewController {
    //MARK:property属性
    let intoButton: UIButton = UIButton.init()
    
    //MARK:system系统
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        self.createMainUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    //MARK:delegate&dataSource代理和数据源
    //MARK:customMethod自定义
    func createMainUI() {
        let scrol:UIScrollView = UIScrollView.init(frame: self.view.frame)
        scrol.bounces = false
        scrol.isPagingEnabled = true
        self.view.addSubview(scrol)
        
        for index in 0...kIndexOfNewFeaturePage {
            let imageView = UIImageView.init(frame: CGRect(x: CGFloat(index)*self.view.width, y: 0.0, width: self.view.width, height: self.view.height))
            imageView.backgroundColor = UIColor.randomColor()
            scrol.addSubview(imageView)
            scrol.contentSize = CGSize.init(width: imageView.right, height: self.view.height)
            if index == 3 {
                intoButton.backgroundColor = UIColor.randomColor()
                intoButton.frame = CGRect(x: imageView.left, y: imageView.centerY, width: imageView.width, height: imageView.height/2.0)
                intoButton.setTitle("进入", for: .normal)
                intoButton.addBlock(controlEvents: UIControlEvents.touchUpInside, block: { (sender) in
                    APPConstant.userDefault.set(APPConstant.currentVersion, forKey: APPConstant.bundleVersionKey)
                    APPConstant.window.rootViewController = SSTabBarPage.init()
                })
                scrol.addSubview(intoButton)
            }
        }
    }
}

