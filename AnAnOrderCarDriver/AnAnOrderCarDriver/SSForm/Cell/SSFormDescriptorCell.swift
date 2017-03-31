//
//  SSFormDescriptorCell.swift
//  SSFormSwiftDemo
//
//  Created by Mac on 17/3/7.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SSFormDescriptorCell {
    @objc func configure() ->Void
    @objc func update() ->Void
    
    @objc optional func formDescriptorCellHeightForRowDescriptor(_ rowDescripotr:SSFormRowDescriptor) ->CGFloat
    
    @objc optional func highLight()
    @objc optional func unhighLight()
}
