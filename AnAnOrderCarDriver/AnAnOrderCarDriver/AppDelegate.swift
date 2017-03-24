//
//  AppDelegate.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/17.
//  Copyright © 2017年 treee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        chooseInterPage()
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    //MARK:控制器的选择
    func chooseInterPage() {
        guard let version:String = APPConstant.appVersion else {
            window?.rootViewController = NewFeaturePage()
            return
        }
        if version == APPConstant.currentVersion {
            window?.rootViewController = SSTabBarPage()
        }
    }
}

