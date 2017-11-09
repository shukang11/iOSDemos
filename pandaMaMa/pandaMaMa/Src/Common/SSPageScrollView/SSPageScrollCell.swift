//
//  SSPageScrollCell.swift
//  pandaMaMa
//
//  Created by tree on 2017/9/1.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
class SSPageScrollCell: UICollectionViewCell {
    
    var imageView: UIImageView = UIImageView()
    var label: UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(label)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        label.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        label.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
