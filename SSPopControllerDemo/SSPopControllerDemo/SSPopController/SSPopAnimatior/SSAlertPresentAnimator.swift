
//
//  SSAlertPresentAnimator.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/10.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

let ss_backgroundAlpha:CGFloat = 0.4

class SSAlertPresentAnimator: NSObject {
    var presentStyle:SSAlertPresentAnimatorType = .system
    
    convenience init(_ presentStyle:SSAlertPresentAnimatorType) {
        self.init()
        self.presentStyle = presentStyle
    }
}

extension SSAlertPresentAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.presentStyle {
        case .system:
            systemAnimateTransition(context: transitionContext)
            break
        case .fadeIn:
            fadeInAnimateTransition(context: transitionContext)
            break
        case .bounce:
            bounceAnimateTransition(context: transitionContext)
            break
        case .expandHorizontal:
            expandHorizontalAnimateTransition(context: transitionContext)
            break
        case .expandVertical:
            expandVerticalAnimateTransition(context: transitionContext)
            break
        case .slideDown:
            slideDownAnimateTransition(context: transitionContext)
            break
        case .slideUp:
            slideUpAnimateTransition(context: transitionContext)
            break
        case .slideLeft:
            slideLeftAnimateTransition(context: transitionContext)
            break
        case .slideRight:
            slideRightAnimateTransition(context: transitionContext)
            break
        }
    }
    //MARK:-
    //MARK:privateMehtod
    func systemAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        let toVC:SSAlertController = transitionContext.viewController(forKey: .to) as! SSAlertController
        let containerView:UIView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        toVC.view.alpha = 0.0
        containerView.addSubview(toVC.view)
        UIView.animate(withDuration: duration, animations: {
            toVC.view.alpha = 1.0
            toVC.backgroundView.alpha = ss_backgroundAlpha
        }) { (complete) in
            transitionContext.completeTransition(true)
        }
    }
    
    func fadeInAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        let toVC:SSAlertController = transitionContext.viewController(forKey: .to) as! SSAlertController
        let containerView:UIView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        toVC.view.alpha = 0.0
        containerView.addSubview(toVC.view)
        UIView.animate(withDuration: duration, animations: {
            toVC.view.alpha = 1.0
            toVC.backgroundView.alpha = ss_backgroundAlpha
        }) { (complete) in
            transitionContext.completeTransition(true)
        }

    }
    
    func bounceAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        let toVC:SSAlertController = transitionContext.viewController(forKey: .to) as! SSAlertController
        let containerView:UIView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        for subview in toVC.view.subviews {
            if subview == toVC.backgroundView {
                subview.alpha = 0.0
                continue
            }
            subview.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
        }
        
        containerView.addSubview(toVC.view)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            for subview in toVC.view.subviews {
                if subview == toVC.backgroundView {
                    subview.alpha = ss_backgroundAlpha
                    continue
                }
                subview.transform = CGAffineTransform.identity
            }
        }) { (complete) in
            transitionContext.completeTransition(true)
        }
    }
    
    func expandHorizontalAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        let toVC:SSAlertController = transitionContext.viewController(forKey: .to) as! SSAlertController
        let containerView:UIView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        for subview in toVC.view.subviews {
            if subview == toVC.backgroundView {
                subview.alpha = 0.0
                continue
            }
            subview.transform = CGAffineTransform.init(scaleX: 0.0, y: 1)
        }
        
        containerView.addSubview(toVC.view)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            for subview in toVC.view.subviews {
                if subview == toVC.backgroundView {
                    subview.alpha = ss_backgroundAlpha
                    continue
                }
                subview.transform = CGAffineTransform.identity
            }
        }) { (complete) in
            transitionContext.completeTransition(true)
        }
    }
    
    func expandVerticalAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        let toVC:SSAlertController = transitionContext.viewController(forKey: .to) as! SSAlertController
        let containerView:UIView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        for subview in toVC.view.subviews {
            if subview == toVC.backgroundView {
                subview.alpha = 0.0
                continue
            }
            subview.transform = CGAffineTransform.init(scaleX: 1, y: 0.0)
        }
        
        containerView.addSubview(toVC.view)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            for subview in toVC.view.subviews {
                if subview == toVC.backgroundView {
                    subview.alpha = ss_backgroundAlpha
                    continue
                }
                subview.transform = CGAffineTransform.identity
            }
        }) { (complete) in
            transitionContext.completeTransition(true)
        }
    }
    
    func slideDownAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        let destinationVC:SSAlertController = transitionContext.viewController(forKey: .to) as! SSAlertController
        let containerView = transitionContext.containerView
        containerView.addSubview(destinationVC.view)
        
        let duration = transitionDuration(using: transitionContext)
        for view in destinationVC.view.subviews {
            if view.isEqual(destinationVC.backgroundView) {
                view.alpha = 0
                continue
            }
            view.center = CGPoint.init(x: view.center.x, y: view.center.y-ScreenSize.height)
        }
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            for subview in destinationVC.view.subviews {
                if subview.isEqual(destinationVC.backgroundView) {
                    subview.alpha = ss_backgroundAlpha
                    continue
                }
                subview.center = CGPoint.init(x: subview.center.x, y: subview.center.y+ScreenSize.height)
            }
        }){ finished in
            transitionContext.completeTransition(true)
        }
    }
    
    func slideUpAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        let destinationVC:SSAlertController = transitionContext.viewController(forKey: .to) as! SSAlertController
        let containerView = transitionContext.containerView
        containerView.addSubview(destinationVC.view)
        
        let duration = transitionDuration(using: transitionContext)
        for view in destinationVC.view.subviews {
            if view.isEqual(destinationVC.backgroundView) {
                view.alpha = 0
                continue
            }
            view.center = CGPoint.init(x: view.center.x, y: view.center.y+ScreenSize.height)
        }
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            for subview in destinationVC.view.subviews {
                if subview.isEqual(destinationVC.backgroundView) {
                    subview.alpha = ss_backgroundAlpha
                    continue
                }
                subview.center = CGPoint.init(x: subview.center.x, y: subview.center.y-ScreenSize.height)
            }
        }){ finished in
            transitionContext.completeTransition(true)
        }
    }
    
    func slideLeftAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        let destinationVC:SSAlertController = transitionContext.viewController(forKey: .to) as! SSAlertController
        let containerView = transitionContext.containerView
        containerView.addSubview(destinationVC.view)
        
        let duration = transitionDuration(using: transitionContext)
        for view in destinationVC.view.subviews {
            if view.isEqual(destinationVC.backgroundView) {
                view.alpha = 0
                continue
            }
            view.center = CGPoint.init(x: view.center.x+ScreenSize.width, y: view.center.y)
        }
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            for subview in destinationVC.view.subviews {
                if subview.isEqual(destinationVC.backgroundView) {
                    subview.alpha = ss_backgroundAlpha
                    continue
                }
                subview.center = CGPoint.init(x: subview.center.x-ScreenSize.width, y: subview.center.y)
            }
        }){ finished in
            transitionContext.completeTransition(true)
        }
    }
    
    func slideRightAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        let destinationVC:SSAlertController = transitionContext.viewController(forKey: .to) as! SSAlertController
        let containerView = transitionContext.containerView
        containerView.addSubview(destinationVC.view)
        
        let duration = transitionDuration(using: transitionContext)
        for view in destinationVC.view.subviews {
            if view.isEqual(destinationVC.backgroundView) {
                view.alpha = 0
                continue
            }
            view.center = CGPoint.init(x: view.center.x-ScreenSize.width, y: view.center.y)
        }
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            for subview in destinationVC.view.subviews {
                if subview.isEqual(destinationVC.backgroundView) {
                    subview.alpha = ss_backgroundAlpha
                    continue
                }
                subview.center = CGPoint.init(x: subview.center.x+ScreenSize.width, y: subview.center.y)
            }
        }){ finished in
            transitionContext.completeTransition(true)
        }
    }
}
