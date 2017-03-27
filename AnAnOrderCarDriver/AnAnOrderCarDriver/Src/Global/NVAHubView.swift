//
//  NVAHubView.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/27.
//  Copyright © 2017年 treee. All rights reserved.
//


//NVActivityIndicatorView
import Foundation
import UIKit
import NVActivityIndicatorView

var activityIndicatorView: NVActivityIndicatorView?

extension UIViewController: NVActivityIndicatorViewable {
    
    public func showDefaultHub(_ subView:UIView, message: String) -> Void {
        activityIndicatorView = NVActivityIndicatorView.init(frame: subView.frame, type: NVActivityIndicatorType.ballZigZag, color: UIColor.blue, padding: 10.0)
        view.addSubview(activityIndicatorView!)
        activityIndicatorView?.size = CGSize.init(width: 90.0, height: 90.0)
        activityIndicatorView?.center = view.center
        activityIndicatorView?.startAnimating()
    }
    
    func hidHub() -> Void {
        guard activityIndicatorView != nil else {
            return
        }
        activityIndicatorView?.stopAnimating()
    }
}
