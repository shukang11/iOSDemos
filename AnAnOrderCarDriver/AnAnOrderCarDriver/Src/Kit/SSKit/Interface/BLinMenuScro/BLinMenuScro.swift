//
//  BLinMenuScro.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/9/29.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit


private let ButtonIndexOffset:Int = 1200
typealias clickBlock = (_ index:Int)->()

/// 一个用于显示横向菜单的控件
class BLinMenuScro: UIScrollView,UIScrollViewDelegate {
    
    //MARK:Properties
    open var menuWidth:CGFloat = 100.0
    
    open var menuDelegate:BLinMenuScrollViewDelegate?
    open var titileArray:[String] = []
    open var baseTitleColor:UIColor? = UIColor.black
    open var hightLightTitileColor:UIColor? = UIColor.white
    open var hightLightBlockColor:UIColor? = UIColor.red
    open var cornerRadios:CGFloat = 5.0
    var baseView:UIView// 标题层
    var specialView:UIScrollView//特效层
    var hightLightBlockView:UIView// 特效色块
    
    var clickAction:clickBlock?
    
    private var buttonArray:NSMutableArray? = []
    //MARK:lifeCycle
    
    override init(frame: CGRect) {
//        self.specialView.isUserInteractionEnabled = false
        self.hightLightBlockView = UIView.init()
        self.specialView = UIScrollView.init()
        self.baseView = UIView.init()
        self.specialView.showsVerticalScrollIndicator = false
        self.specialView.showsHorizontalScrollIndicator = false
        self.buttonArray = NSMutableArray.init(capacity: 0)
        super.init(frame: frame)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:Delegate&DateSource
    
    //MARK:CustomMethod
    open func create(titles:[String], _ clickEvent:@escaping clickBlock) {
        self.titileArray = titles
        self.clickAction = clickEvent
        createMainUI()
    }
    
    func createMainUI() {
        if self.titileArray.isEmpty { return}
        createBaseView()
        createHightLightView()
    }
    func removeAllSubjects() {
        while self.baseView.subviews.count > 0 {
            self.baseView.subviews.last?.removeFromSuperview()
        }
        self.hightLightBlockView.removeFromSuperview()
        while self.specialView.subviews.count > 0 {
            self.specialView.subviews.last?.removeFromSuperview()
        }
    }
    func createBaseView() {
        if menuWidth*CGFloat(self.titileArray.count) < self.frame.size.width {
            menuWidth = self.frame.size.width/CGFloat(self.titileArray.count)
        }
        baseView.frame = CGRect(x: 0.0, y: 0.0,width: menuWidth*CGFloat(self.titileArray.count), height: self.frame.size.height)
        for index in 0...self.titileArray.count-1 {
            let rect = self.countRect(index)
            let label = UILabel.init(frame: rect)
            label.text = self.titileArray[index]
            label.textColor = baseTitleColor
            label.textAlignment = NSTextAlignment.center
            baseView.addSubview(label)
        }
        self.addSubview(baseView)
    }
    func createHightLightView() {
        //block
        self.hightLightBlockView.frame = CGRect(x: 0.0, y: 0.0, width: menuWidth, height: self.frame.size.height)
        self.hightLightBlockView.layer.cornerRadius = self.cornerRadios
        self.hightLightBlockView.layer.masksToBounds = true
        self.hightLightBlockView.backgroundColor = hightLightBlockColor
        self.addSubview(self.hightLightBlockView)
        
        self.specialView.frame = self.hightLightBlockView.frame
        for index in 0...self.titileArray.count-1 {
            let rect = self.countRect(index)
            let label = UILabel.init(frame: rect)
            label.text = self.titileArray[index]
            label.textColor = hightLightTitileColor
            label.textAlignment = NSTextAlignment.center
            specialView.addSubview(label)
            specialView.contentSize = CGSize(width: rect.maxX, height: self.frame.size.height)
        }
        self.addSubview(specialView)
        for buttonIndex in 0...self.titileArray.count-1 {
            let button =  UIButton.init(frame: countRect(buttonIndex))
            button.addTarget(self, action: #selector(buttonClicked(_:)), for: UIControlEvents.touchUpInside)
            button.tag = buttonIndex+ButtonIndexOffset
            self.addSubview(button)
            self.contentSize = CGSize(width: countRect(buttonIndex).maxX, height: countRect(buttonIndex).maxY)
            buttonArray?.add(button)
        }
    }
    
    
    func countRect(_ offset:Int)->CGRect {
        let rect = CGRect(x: menuWidth*CGFloat(offset), y: 0.0, width: menuWidth, height: self.frame.size.height)
        return rect
    }
    
    func buttonClicked(_ sender:UIButton) {
        for index in 0...(self.buttonArray?.count)!-1 {
            let button = self.buttonArray?.object(at: index) as! UIButton
            button.isUserInteractionEnabled = false
        }
        
        self.menuDelegate?.willMove?(self, index: sender.tag-ButtonIndexOffset)
        UIView.animate(withDuration: 0.3, animations: { 
            self.hightLightBlockView.frame = self.countRect(sender.tag-ButtonIndexOffset)
            self.specialView.frame = self.hightLightBlockView.frame
            self.specialView.contentOffset = CGPoint(x: self.specialView.frame.origin.x, y: self.specialView.frame.origin.y)
        }) { (complete) in
            for index in 0...(self.buttonArray?.count)!-1 {
                let button = self.buttonArray?.object(at: index) as! UIButton
                button.isUserInteractionEnabled = true
            }
            self.menuDelegate?.didClick?(self, index: sender.tag-ButtonIndexOffset)
            self.clickAction!(sender.tag-ButtonIndexOffset)
        }
    }
}

@objc protocol BLinMenuScrollViewDelegate {
    @objc optional func willMove(_ menuScrollView: BLinMenuScro, index: Int)
    @objc optional func didClick(_ menuScrollView: BLinMenuScro, index: Int)
}
