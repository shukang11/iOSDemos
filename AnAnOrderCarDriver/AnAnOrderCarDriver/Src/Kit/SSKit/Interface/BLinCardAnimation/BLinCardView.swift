//
//  BLinCardView.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit
class BLinCardView: UIView {
    //MARK: properties
    open var headerImageView: UIImageView = UIImageView.init()
    open var numberLabel: UILabel?
    open var leftButton: UIButton?
    open var rightButton: UIButton?
    open var canPan:Bool?
    
    open var infoDict:String = "FICDDemoImage001.jpg"
    open var originalPoint: CGPoint?
    open var originalCenter:CGPoint?
    open var panGuesture: UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(beginDragged(_:)))
    open var originalTransform: CGAffineTransform?

    //MARK: lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 4.0
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowPath = UIBezierPath.init(rect: self.bounds).cgPath
        self.addGestureRecognizer(self.panGuesture)
        let bgView = UIView.init(frame: self.frame)
        bgView.layer.cornerRadius = 4.0
        bgView.clipsToBounds = true
        self.addSubview(bgView)
        self.headerImageView.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        self.headerImageView.backgroundColor = UIColor.white
        self.headerImageView.isUserInteractionEnabled = true
        bgView.addSubview(self.headerImageView)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapGuesture(_:)))
        self.headerImageView.addGestureRecognizer(tap)
        
        self.layer.allowsEdgeAntialiasing = true
        bgView.layer.allowsEdgeAntialiasing = true
        self.headerImageView.layer.allowsEdgeAntialiasing = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: Delegate&DataSource
    
    //MARK: CustomMethod
    func beginDragged(_ pan: UIPanGestureRecognizer) {
        
    }
    func tapGuesture(_  tap: UITapGestureRecognizer) {
        if self.canPan == false { return}
    }
    override func layoutSubviews() {
        
        self.headerImageView.image = UIImage.init(named: self.infoDict)
    }
}
