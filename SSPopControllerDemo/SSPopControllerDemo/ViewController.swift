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
        let alertController:SSAlertController = SSAlertController.init("title", message: "messagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessage", alertStyle: .systemAlert)
        alertController.dismissStyle = .slideDown
        alertController.presentStyle = .slideUp
        for _ in 1...3 {
            let action:SSAlertAction = SSAlertAction.init(title: "button1", style: .Default, handler: {
                print("button1")
            })
            alertController.contentView.addAction(action: action)
        }
        let action:SSAlertAction = SSAlertAction.init(title: "button1", style: .Cancel, handler: {
            print("button1")
        })
        alertController.contentView.addAction(action: action)
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

