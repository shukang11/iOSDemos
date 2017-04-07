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
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:-
    //MARK:public
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            viewController.navigationItem.leftBarButtonItem = self.itemWith(self, action: #selector(self.backForward), image: "navigationbar_back", highlightImage: "navigationbar_back_highlighted")
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func backForward() {
        self.popViewController(animated: true)
    }
    
    func backToRoot() -> Void {
        self.popToRootViewController(animated: true)
    }
    
    
    func itemWith(_ target:Any, action:Selector, image:String, highlightImage:String) -> UIBarButtonItem {
        let btn: UIButton = UIButton.init(type: .custom)
        btn.setBackgroundImage(UIImage.init(named: image), for: .normal)
        btn.setBackgroundImage(UIImage.init(named: highlightImage), for: .highlighted)
        
        btn.size = (btn.currentBackgroundImage?.size)!
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
}

