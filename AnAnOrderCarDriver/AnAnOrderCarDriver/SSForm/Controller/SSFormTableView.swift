//
//  SSFormTableView.swift
//  SSFormSwiftDemo
//
//  Created by Mac on 17/3/28.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

///自定义的单元格控件
class SSFormTable: UITableView {
    //MARK:-
    //MARK:properties
    var sourceHelper: SSFormTableViewSourceHelper?
    
    //MARK:-
    //MARK:lifeCycle
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
