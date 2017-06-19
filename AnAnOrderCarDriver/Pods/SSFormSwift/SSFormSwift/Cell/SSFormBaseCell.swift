//
//  SSFormBaseCell.swift
//  SSFormSwiftDemo
//
//  Created by Mac on 17/3/7.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

open class SSFormBaseCell: UITableViewCell,SSFormDescriptorCell {
    var rowDescriptor:SSFormRowDescriptor?
    public var value:AnyObject?
    
    //MARK:-
    //MARK:liftCycle
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    public required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:-
    //MARK:public
    
    
    //MARK:-
    //MARK:SSFormDescriptorCell
    func configure() {
        self.selectionStyle = .none
    }
    
    func update() {
        self.textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        self.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    override open func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
