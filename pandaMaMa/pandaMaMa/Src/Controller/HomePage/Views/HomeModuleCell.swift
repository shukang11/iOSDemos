//
//  HomeModuleCell.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/19.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit
private let buttonHeight: CGFloat = 80.0
class HomeModuleCell: UITableViewCell {
    var modules: [__Module] = []//按钮的集合
    
    let scroll: UIScrollView = UIScrollView.init()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(scroll)
        scroll.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellButtons(buttonInfo: [[String: AnyObject]]) -> Void {
        for button in modules { button.removeFromSuperview() }
        modules.removeAll()
        for dict in buttonInfo {
            modules.append({
                let butt = __Module.init()
                butt.label.text = dict.stringValue(key: "name")
                butt.img.setImageURL(picUrl: URL.init(string: dict.stringValue(key: "pic")))
                return butt
                }())
        }
        let lineNum = 4
        let btnWidth = (kScreenWidth/CGFloat(lineNum))
        for i in 0..<modules.count {
            let o = modules[i]
            o.size = CGSize.init(width: btnWidth, height: buttonHeight)
            o.left = (CGFloat(i%4)*btnWidth) + (CGFloat(i/8)*kScreenWidth)
            o.top = CGFloat((i%8)/4)*buttonHeight
            scroll.addSubview(o)
        }
        scroll.contentSize = CGSize.init(width: kScreenWidth*CGFloat(modules.count/8+1), height: 2*buttonHeight)
    }
    
    class func cellHeight(modules: [[String: AnyObject]]?) -> CGFloat {
        guard let buttons = modules else { return 0.01 }
        if buttons.count == 0 {return 0.01}
        if (buttons.count >= 1 && buttons.count <= 4) {
            return buttonHeight
        }else { return 2 * buttonHeight }
    }
}

class __Module: UIView {
    var img: UIImageView = UIImageView()
    var label: UILabel = UILabel()
    var title: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(img)
        self.addSubview(label)
        
        label.textAlignment = .center
        label.font = UIFont.limitFont()
        label.textColor = UIColor.black_font()
        
        img.contentMode = .scaleAspectFit
        
        img.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.width.equalTo(img.snp.height)
        }
        label.snp.makeConstraints { (make) in
            make.top.equalTo(img.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX)
            make.width.lessThanOrEqualToSuperview()
            make.height.greaterThanOrEqualTo(20.0)
            make.bottom.lessThanOrEqualTo(self.snp.bottom)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
