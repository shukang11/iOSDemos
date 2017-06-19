//
//  SSView.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/9/16.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    public var left : CGFloat {
        get {
            return frame.origin.x
        }
        set(newLeft) {
            var tempFrame : CGRect = frame
            tempFrame.origin.x = newLeft
            frame = tempFrame
        }
    }
    public var top : CGFloat {
        get {
            return frame.origin.y
        }
        set(newTop) {
            var tempFrame : CGRect = frame
            tempFrame.origin.y = newTop
            frame = tempFrame
        }
    }
    public var right : CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        
        set(newRight) {
            var tempFrame : CGRect = frame
            tempFrame.origin.x = newRight - frame.size.width;
            frame = tempFrame
        }
    }
    public var bottom : CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        
        set(newBottom) {
            var tempFrame : CGRect = frame
            tempFrame.origin.y = newBottom - frame.size.height
            frame = tempFrame
        }
    }
    
    public var width : CGFloat {
        get {
            return frame.size.width
        }
        set(newWidth) {
            var tempFrame : CGRect = frame
            tempFrame.size.width = newWidth
            frame = tempFrame
        }
    }
    
    public var height : CGFloat {
        get {
            return frame.size.height
        }
        set(newHeight) {
            var tempFrame : CGRect = frame
            tempFrame.size.height = newHeight
            frame = tempFrame
        }
    }
    public var centerX : CGFloat {
        get {
            return self.center.x
        }
        set(newCenterX) {
            self.center = CGPoint.init(x: newCenterX, y: self.center.y)
        }
    }
    
    public var centerY : CGFloat {
        get {
            return self.center.y
        }
        set(newCenterY) {
            self.center = CGPoint.init(x: self.center.x, y: newCenterY)
        }
    }
    
    public var size : CGSize {
        get {
            return self.frame.size
        }
        set(newSize) {
            var tempFrame : CGRect = frame
            tempFrame.size = newSize
            frame = tempFrame
        }
    }
    
    public var origin : CGPoint {
        get {
            return frame.origin
        }
        set(newOrigin) {
            var tempFrame : CGRect = frame
            tempFrame.origin = newOrigin
            frame = tempFrame
        }
    }
    //MARK:Method
    public func viewController() -> UIViewController? {
        var view : UIView = self
        var nextResponder : UIResponder = view.superview!
        while (view.superview != nil) {
            view = view.superview!
            nextResponder = view.next!
            if (nextResponder.isKind(of: UIViewController.self)) {
                return nextResponder as? UIViewController
            }
        }
        return nil
    }
    
    public func removeAllObjects() {
        while self.subviews.count > 0 {
            self.subviews.last?.removeFromSuperview()
        }
    }
    
    public func backgroundColor(_ image: UIImage) {
        self.backgroundColor = UIColor.init(patternImage: image)
    }
    public func cleanSubColors() {
        for view in self.subviews {
            view.backgroundColor = UIColor.clear
        }
        self.backgroundColor = UIColor.clear
    }
    
    ///调试模式下，将所有视图和其子视图描边显示
    public func debugModeColor() {
        self.backgroundColor = UIColor.randomColor()
        for view in self.subviews {
            if (view.subviews.count > 0) {view.debugModeColor()}
            view.backgroundColor = UIColor.randomColor()
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 0.5
        }
    }
    
    //MARK:animate动画
    
    public func shake(_ size: CGSize) {
        let layer:CALayer = self.layer;
        let position:CGPoint = layer.position;
        let xPosition:CGPoint = CGPoint.init(x: position.x+size.width, y: position.y+size.height)
        let yPosition:CGPoint = CGPoint.init(x: position.x-size.width, y: position.y-size.height)
        let animate:CABasicAnimation = CABasicAnimation.init(keyPath: "position")
        animate.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionDefault)
        animate.fromValue = NSValue.init(cgPoint: xPosition)
        animate.toValue = NSValue.init(cgPoint: yPosition)
        animate.autoreverses = true
        animate.duration = 0.06
        animate.repeatCount = 1
        layer.add(animate, forKey: nil)
    }
}
