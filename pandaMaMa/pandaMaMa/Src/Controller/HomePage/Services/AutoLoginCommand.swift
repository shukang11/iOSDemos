//
//  AutoLoginCommand.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/15.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation

class AutoLoginCommand: Command {
    override func execute() {
        //执行结束。清除
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+4) {
            DLog("执行自动登录")
            self.done()
        }
    }
    override func done() {
        CommandManager.sharedInstance.cancelCommand(self)
    }
}
