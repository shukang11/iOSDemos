//
//  BHPopAnimation.swift
//  SwiftPushAndPopDemo
//
//  Created by healthmanage on 16/12/8.
//  Copyright © 2016年 healthmanager. All rights reserved.
//返回的弹跳效果

import Foundation
import UIKit

class BHPopAnimation: NSObject,UIViewControllerAnimatedTransitioning{
    
    var transitionContext:UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        //不添加的话，屏幕什么都没有
        let containerView = transitionContext.containerView
        containerView.addSubview((fromVC?.view)!)
        containerView.addSubview((toVC?.view)!)
        
        let durationN = self.transitionDuration(using: transitionContext)
        let screenBounds:CGRect = UIScreen.main.bounds
        let finalFrame:CGRect = transitionContext.finalFrame(for: toVC!)
        //OC中CGRectOffset(finalFrame, 0, -screenBounds.size.height)的Swift的用法：finalFrame.offsetBy(dx: 0, dy: -screenBounds.size.height)
        toVC?.view.frame = finalFrame.offsetBy(dx: 0, dy: -screenBounds.size.height)

        //添加动画，有弹跳的效果,参数：usingSpringWithDamping的范围为0.0f到1.0f，数值越小「弹簧」的振动效果越明显，当设置为1.0时，就不弹跳
        //toVC?.view.frame = finalFrame
        //transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        UIView.animate(withDuration: durationN, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {() -> Void in
            //print("11111111")
            toVC?.view.frame = finalFrame
        }, completion: ({(Bool) -> Void in
            //print("22222222")
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }))
    }
}
