//
//  UserCenterHeaderCell.swift
//  pandaMaMa
//
//  Created by tree on 2018/3/30.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import UIKit

/// 个人中心头像行
class UserCenterHeaderCell: UITableViewCell {
    public var headerImageView: UIImageView = {
        let o = UIImageView.init()
        o.contentMode = .scaleAspectFit
        return o
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.headerImageView)
        self.headerImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(150.pd_scale())
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
