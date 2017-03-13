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

enum SSAlertControllerStyle {
    case action
    case alert
    case custom
}

class SSAlertController: UIViewController {
    //MARK:-
    //MARK:properties
    var style:SSAlertControllerStyle!
    var dismissStyle:SSAlertDismissAnimatorType = .slideDown
    var presentStyle:SSAlertPresentAnimatorType = .bounce
    
    var contentView:SSAlertBaseView!
    
    
    public lazy var backgroundView:UIView = {
        let view:UIView = UIView.init(frame: self.view.bounds)
        view.backgroundColor = UIColor.black
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapToDismiss(_:)))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    //MARK:-
    //MARK:lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    convenience init(_ title:String, message:String, alertStyle:SSAlertControllerStyle) {
        self.init()
        self.style = alertStyle
        
        //如果不添加这个视图，跳转完成之后会变成黑色
        
        /**
         要在初始化的时候就添加视图才行。否则就迟了！
         */
        setupViews()
    }
    //MARK:-
    //MARK:public
    
    func addAction(action:SSAlertAction) -> Void {
        contentView.actions.append(action)
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
        setupBackgroundViewContraints()
        
        if self.style == SSAlertControllerStyle.alert {
            self.contentView = SSAlertView(title: "", message: "", viewCOntroller: self)
        }else if self.style == SSAlertControllerStyle.action {
            self.contentView = SSActionView(title: "", message: "", viewController: self)
            
            view.addSubview(contentView)
        }else if self.style == SSAlertControllerStyle.custom {
            
        }
        
        self.contentView.updateLayouts()
    }
    
    func setupBackgroundViewContraints() -> Void {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: backgroundView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.init(item: backgroundView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.init(item: backgroundView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint.init(item: backgroundView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
    }
 
}

extension SSAlertController {
    func tapToDismiss(_ tap:UITapGestureRecognizer) -> Void {
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
