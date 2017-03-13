//
//  ViewController.swift
//  SSPopControllerDemo
//
//  Created by Mac on 17/3/9.
//  Copyright © 2017年 treee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        
        let square = UIButton.init()
        square.frame = CGRect.init(x: 100.0, y: 100.0, width: 100.0, height: 100.0)
        square.backgroundColor = UIColor.red
        square.addTarget(self, action: #selector(ViewController.clicked), for: .touchUpInside)
        self.view.addSubview(square)
        
    }
    func clicked() -> Void {
        let alertController:SSAlertController = SSAlertController.init("", message: "", alertStyle: .action)
        alertController.dismissStyle = .slideLeft
        alertController.presentStyle = .slideLeft
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

