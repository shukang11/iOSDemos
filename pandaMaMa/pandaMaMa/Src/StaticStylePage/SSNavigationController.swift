//
//  SSNavigationController.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/24.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

class SSNavigationController: UINavigationController {
    
    //MARK:-
    //MARK:property
    fileprivate var screenShotImageView: UIImageView {// 截图
        // 创建当前的截图
        let screenShotImageView = UIImageView.init()
        screenShotImageView.frame = APPConstant.windowBounds
        return screenShotImageView
    }
    
    fileprivate var coverView: UIView {// 遮罩层
        // 创建遮罩层
        let coverView = UIView.init()
        coverView.frame = self.screenShotImageView.bounds
        coverView.backgroundColor = UIColor.black
        return coverView
    }
    fileprivate var screenShotImages: [UIImage] = {//  截图的对象数组
        // 存放所有截图的数组
        return [UIImage]()
    }()
    
    let k_default_alpha: CGFloat = 0.6
    let k_target_translate_scale: CGFloat = 0.75
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-
    //MARK:public
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = self.itemWith(self, action: #selector(self.backForward), image: "navigationbar_back", highlightImage: "navigationbar_back_highlighted")
            self.interactivePopGestureRecognizer?.delegate = viewController as? UIGestureRecognizerDelegate
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @discardableResult
    override func popViewController(animated: Bool) -> UIViewController? {
        let num = self.viewControllers.count
        // 推出栈
        if screenShotImages.count >= max(0, num - 1) {
           let _ = screenShotImages.popLast()
        }
        return super.popViewController(animated: animated)
    }
    
    @discardableResult
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        screenShotImages.removeAll()
        return super.popToRootViewController(animated: animated)
    }
    func backForward() {
        popViewController(animated: true)
    }
    
    func backToRoot() -> Void {
        self.popToRootViewController(animated: true)
        self.interactivePopGestureRecognizer?.delegate = nil
    }
    
    
    func itemWith(_ target:Any, action:Selector, image:String, highlightImage:String) -> UIBarButtonItem {
        let btn: UIButton = UIButton.init(type: .custom)
        btn.setBackgroundImage(UIImage.init(named: image), for: .normal)
        btn.setBackgroundImage(UIImage.init(named: highlightImage), for: .highlighted)
        if let size = (btn.currentBackgroundImage?.size) { btn.frame.size = size }else {
            btn.frame.size = CGSize.init(width: 45.0, height: 35.0)
        }
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem.init(customView: btn)
    }
    
    //MARK:-
    //MARK:转屏设置
    override var shouldAutorotate: Bool {
        guard self.topViewController != nil else {
            return false
        }
        return (self.topViewController?.shouldAutorotate)!
    }
    //支持的转屏方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard self.topViewController != nil else {
            return .portrait
        }
        return (self.topViewController?.supportedInterfaceOrientations)!
    }
    
    //MARK:-
    //MARK:导航栏样式
}


