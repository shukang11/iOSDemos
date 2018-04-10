//
//  HomeCrossCell.swift
//  pandaMaMa
//
//  Created by tree on 2017/9/5.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit

// 跨境购
class HomeCrossCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cell_height(_ count: NSInteger) -> Float {
        var height: Float = 0.01;
        
        return height
    }
    
}
