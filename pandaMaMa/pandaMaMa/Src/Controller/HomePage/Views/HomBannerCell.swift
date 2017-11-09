//
//  HomBannerCell.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/18.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit

class HomeBannerCell:UITableViewCell  {
    var bannerArray: [[String: AnyObject]] {
        didSet {
            var o: [String] = []
            for dict in bannerArray {
                o.append(dict.stringValue(key:"pic"))
            }
            scrollView.urlImages = o
            scrollView.autoScroll = true
        }
    }
    let scrollView: SSPageScrollView = SSPageScrollView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.bannerArray = []
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellHeight() -> CGFloat {
        return kScreenWidth * kBanner_scale
    }
}
