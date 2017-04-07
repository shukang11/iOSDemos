//
//  SSFormSystemTextCell.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/28.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

class SSFormSystemTextCell: SSFormBaseCell {
    
    override func update() {
        super.update()
        let str:[String:String] = self.rowDescriptor?.value as! [String:String]
        self.textLabel?.text = str["title"] ?? ""
        self.detailTextLabel?.text = str["detailLabel"] ?? ""
        
    }
    
    override func configure() {
        super.configure()
        print("\(self.detailTextLabel?.text)")
    }
}


class demoCell: SSFormBaseCell {
    var name:String = ""
    
    override func update() {
        super.update()
        self.textLabel?.text = "\(self.rowDescriptor?.value as! String))"
    }
    
    override func configure() {
        super.configure()
        textLabel?.textColor = UIColor.red
    }
}

