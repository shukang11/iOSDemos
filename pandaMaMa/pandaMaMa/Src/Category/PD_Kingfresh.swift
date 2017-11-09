//
//  PD_Kingfresh.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/23.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


extension UIButton {
    func setImageURL(picUrl: URL?, state: UIControlState) {
        self.kf.setImage(with: picUrl, for: state)
    }
}

extension UIImageView {
    func setImageURL(picUrl: URL?) {
        self.kf.setImage(with: picUrl)
    }
    
    func setImageURL(picURL: URL?, placeholder: UIImage?) {
        self.kf.setImage(with: picURL, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
    }
}

