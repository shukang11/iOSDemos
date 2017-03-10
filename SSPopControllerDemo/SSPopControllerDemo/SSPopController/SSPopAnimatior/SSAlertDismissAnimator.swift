//
//  SSAlertDismissAnimator.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/10.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

class SSAlertDismissAnimator: NSObject {
    var dismissType:SSAlertDismissAnimatorType = .fadeOut
    
    convenience init(_ dismissStyle:SSAlertDismissAnimatorType) {
        self.init()
        self.dismissType = dismissStyle
    }
}

extension SSAlertDismissAnimator:UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.dismissType {
        case .fadeOut:
            fadeOutAnimateTransition(context: transitionContext)
            break
        case .contractHorizontal:
            contractHorizontalAnimateTransition(context: transitionContext)
            break
        case .contractVertical:
            contractVerticalAnimateTransition(context: transitionContext)
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
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    //MARK:-
    //MARK:privateMehtod
    func fadeOutAnimateTransition(context transitionContext: UIViewControllerContextTransitioning) -> Void {
        let fromVC:SSAlertController = transitionContext.viewController(forKey: .from) as! SSAlertController
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            fromVC.backgroundView.alpha = 0.0
        }) { (complete) in
            transitionContext.completeTransition(true)
        }
    }
    func contractHorizontalAnimateTransition(context transitionContext: UIViewControllerContextTransitioning) -> Void {
        
    }
    func contractVerticalAnimateTransition(context transitionContext: UIViewControllerContextTransitioning) -> Void {
        
    }
    func slideDownAnimateTransition(context transitionContext: UIViewControllerContextTransitioning) -> Void {
        
    }
    func slideUpAnimateTransition(context transitionContext: UIViewControllerContextTransitioning) -> Void {
        
    }
    func slideLeftAnimateTransition(context transitionContext: UIViewControllerContextTransitioning) -> Void {
        
    }
    func slideRightAnimateTransition(context transitionContext: UIViewControllerContextTransitioning) -> Void {
        
    }

}
