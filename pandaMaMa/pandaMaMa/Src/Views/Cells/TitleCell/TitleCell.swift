//
//  TitleCell.swift
//  pandaMaMa
//
//  Created by tree on 2018/3/30.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import UIKit
/// 个人中心行
final class TitleCell: UITableViewCell {
    
    public var titleLabel: UILabel = {
        let o = UILabel.init()
        o.numberOfLines = 0
        return o
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(26.pd_scale())
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
