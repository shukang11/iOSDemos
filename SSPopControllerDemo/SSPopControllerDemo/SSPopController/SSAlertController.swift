//
//  SSAlertController.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/10.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

struct ScreenSize {
    private static let screenBounds = UIScreen.main.bounds
    static let width = ScreenSize.screenBounds.width
    static let height = ScreenSize.screenBounds.height
}


class SSAlertController: UIViewController {
    
    //MARK:-
    //MARK:properties
    
    var dismissStyle:SSAlertDismissAnimatorType = .fadeOut
    var presentStyle:SSAlertPresentAnimatorType = .system
    
    var alertView:SSAlertView!
    public lazy var backgroundView:UIView = {
        let view:UIView = UIView.init(frame: self.view.bounds)
        view.backgroundColor = UIColor.black
        view.alpha = 0.4
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(SSAlertController.dismiss as (SSAlertController) -> () -> Void))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    //MARK:-
    //MARK:lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("\(alertView.frame)---\(backgroundView.frame)")
    }
    convenience init(_ title:String, message:String) {
        self.init()
        let alertView:SSAlertView = SSAlertView.init(title, message: message)
        self.alertView = alertView
        //如果不添加这个视图，跳转完成之后会变成黑色
        
        /**
         要在初始化的时候就添加视图才行。否则就迟了！
         */
        setupViews()
    }

    //MARK:-
    //MARK:private
    private func initialize() {
        transitioningDelegate = self
        modalPresentationStyle = .custom
        view.backgroundColor = UIColor.clear
        
    }
    
    func setupViews() {
        view.addSubview(backgroundView)
        view.addSubview(alertView)
        setupAlertViewContraints()
    }
    
    func setupAlertViewContraints() -> Void {
        NSLayoutConstraint(item: alertView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: alertView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: alertView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
    }
 

}

extension SSAlertController {
    func dismiss() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SSAlertController:UIViewControllerTransitioningDelegate {
   
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SSAlertDismissAnimator.init(self.dismissStyle)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SSAlertPresentAnimator.init(self.presentStyle)
    }
}
