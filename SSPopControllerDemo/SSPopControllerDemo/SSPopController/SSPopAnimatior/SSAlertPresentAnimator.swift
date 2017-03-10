
//
//  SSAlertPresentAnimator.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/10.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

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
        }) { (complete) in
            transitionContext.completeTransition(true)
        }
    }
    
    func fadeInAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        let destinationVC:SSAlertController = transitionContext.viewController(forKey: .to) as! SSAlertController
        destinationVC.backgroundView.alpha = 0;
        let containerView = transitionContext.containerView
        containerView.addSubview(destinationVC.view)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            destinationVC.backgroundView.alpha = 0.4
        }){ finished in
            transitionContext.completeTransition(true)
        }
    }
    
    func bounceAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        
    }
    
    func expandHorizontalAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        
    }
    
    func expandVerticalAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        
    }
    
    func slideDownAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        
    }
    
    func slideUpAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        
    }
    
    func slideLeftAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        
    }
    
    func slideRightAnimateTransition(context transitionContext:UIViewControllerContextTransitioning) -> Void {
        
    }
}
