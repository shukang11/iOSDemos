//
//  HomeCenterTitleCell.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/19.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit

class HomeCenterTitleCell: UITableViewCell {
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    var titleImage: UIImage? {
        get { return titleImageView.image }
        set { titleImageView.image = newValue }
    }
    
    var titleColor: UIColor {
        get { return titleLabel.textColor }
        set { titleLabel.textColor = newValue }
    }
    
    private var titleLabel: UILabel = {
        let label: UILabel = UILabel.init()
        label.numberOfLines = 0
        label.textColor = UIColor.black_font()
        label.font = UIFont.titleFont()
        return label
    }()
    private var titleImageView: UIImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        let helperView: UIView = UIView()
        helperView.addSubview(titleImageView)
        helperView.addSubview(titleLabel)
        self.contentView.addSubview(helperView)
        helperView.backgroundColor = UIColor.randomColor()
        helperView.snp.makeConstraints { (make) in
            make.left.equalTo(titleImageView.snp.left)
            make.right.equalTo(titleLabel.snp.right)
            make.center.equalTo(self.contentView.snp.center)
        }
        titleImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(helperView.snp.centerY)
            make.right.equalTo(titleLabel.snp.left).offset(-kSpan_general)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(helperView.snp.centerY)
            make.left.equalTo(titleImageView.snp.right).offset(kSpan_general)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellHeight() -> CGFloat {
        return 50.0
    }
}
