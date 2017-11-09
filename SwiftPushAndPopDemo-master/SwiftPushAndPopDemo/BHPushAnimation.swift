//
//  BHPushAnimation.swift
//  SwiftPushAndPopDemo
//
//  Created by healthmanage on 16/12/8.
//  Copyright © 2016年 healthmanager. All rights reserved.
//跳转的扇形效果

import Foundation
import UIKit

class BHPushAnimation: NSObject,UIViewControllerAnimatedTransitioning,CAAnimationDelegate {
    
    var transitionContextT:UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContextT = transitionContext
        
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        //不添加的话，屏幕什么都没有
        let containerView = transitionContext.containerView
        containerView.addSubview((fromVC?.view)!)
        containerView.addSubview((toVC?.view)!)
        
        let originRect:CGRect = CGRect.init(x: 0, y: 0, width: 50, height: 50)
        let maskStartPath = UIBezierPath.init(ovalIn: originRect)
        //OC中CGRectInset(originRect, -2000, -2000)的Swift用法:originRect.insetBy(dx: -2000, dy: -2000)
        let maskEndPath = UIBezierPath.init(ovalIn: originRect.insetBy(dx: -2000, dy: -2000))
        
        //创建一个CAShapeLayer来负责展示圆形遮盖
        let maskLayer = CAShapeLayer.init()
        //将他的path指定为最终的path，来避免在动画完成后回弹
        maskLayer.path = maskEndPath.cgPath
        
        toVC?.view.layer.mask = maskLayer
        
        let maskAnimation = CABasicAnimation.init(keyPath: "path")
        maskAnimation.fromValue = maskStartPath.cgPath
        maskAnimation.toValue = maskEndPath.cgPath
        maskAnimation.duration = self.transitionDuration(using: transitionContext)
        maskAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        maskAnimation.fillMode = kCAFillModeForwards
        maskAnimation.isRemovedOnCompletion = false
        maskAnimation.delegate = self
        maskLayer.add(maskAnimation, forKey: "path")
        
    }
    //MARK:----- CAAnimationDelegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.transitionContextT?.completeTransition(!(self.transitionContextT?.transitionWasCancelled)!)
        //去除mask
        self.transitionContextT?.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.layer.mask = nil;
        self.transitionContextT?.viewController(forKey: UITransitionContextViewControllerKey.to)?.view.layer.mask = nil;
    }
    
}
