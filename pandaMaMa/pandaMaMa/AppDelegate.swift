//
//  AppDelegate.swift
//  pandaMaMa
//
//  Created by tree on 2017/5/17.
//  Copyright © 2017年 tree. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        if let path = Bundle.main.path(forResource: "module", ofType: "plist") {
            ModuleManager.sharedManager.register(contentPath: path)
        }
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        _ = ModuleManager.sharedManager.application(application, didFinishLaunchingWithOptions: launchOptions)
        self.window?.backgroundColor = UIColor.white
        chooseInterPage()
        self.window?.makeKeyAndVisible()
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        ModuleManager.sharedManager.applicationWillResignActive(application)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       ModuleManager.sharedManager.applicationDidEnterBackground(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        ModuleManager.sharedManager.applicationWillEnterForeground(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        ModuleManager.sharedManager.applicationWillTerminate(application)
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

