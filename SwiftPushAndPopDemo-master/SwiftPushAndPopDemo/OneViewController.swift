//
//  OneViewController.swift
//  SwiftPushAndPopDemo
//
//  Created by healthmanage on 16/12/8.
//  Copyright © 2016年 healthmanager. All rights reserved.
//

import Foundation
import UIKit

class OneViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "跳转到第一个界面"
        self.view.backgroundColor = UIColor.lightGray
        
        
        let popBtn = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: (self.view.frame.size.width-100)/2, height: 50))
        popBtn.setTitle("POP", for: .normal)
        popBtn.setTitleColor(UIColor.blue, for: .normal)
        popBtn.addTarget(self, action: #selector(popBtnClick), for: .touchUpInside)
        self.view.addSubview(popBtn)
        
    }
    //按钮点击
    func popBtnClick(btn:UIButton) {
        //print("11111111")
        self.navigationController!.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

