//
//  ViewController.swift
//  SwiftPushAndPopDemo
//
//  Created by healthmanage on 16/12/8.
//  Copyright © 2016年 healthmanager. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "首页"
        self.view.backgroundColor = UIColor.white
        
        self.navigationController?.delegate = self
        
        let pushBtn = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: (self.view.frame.size.width-100)/2, height: 50))
        pushBtn.setTitle("PUSH", for: .normal)
        pushBtn.setTitleColor(UIColor.blue, for: .normal)
        pushBtn.addTarget(self, action: #selector(pushBtnClick), for: .touchUpInside)
        self.view.addSubview(pushBtn)
        
    }
    //按钮点击
    func pushBtnClick(btn:UIButton) {
        let oneVC = OneViewController()
        self.navigationController?.pushViewController(oneVC, animated: true)
    }
    //MARK:-----UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation==UINavigationControllerOperation.push {
            return BHPopAnimation()
        }
        else if operation==UINavigationControllerOperation.pop{
            return BHPushAnimation()
        }
        return nil
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

