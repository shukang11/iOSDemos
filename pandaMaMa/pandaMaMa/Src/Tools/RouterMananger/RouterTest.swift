//
//  RouterTest.swift
//  pandaMaMa
//
//  Created by tree on 2018/2/26.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import UIKit

class RouterTest: NSObject, HookModuleProtocol {
    public func register(contentPath: String) -> Void {
        guard FileManager.default.fileExists(atPath: contentPath) else { return  }
        guard let sourceDict = NSDictionary.init(contentsOfFile: contentPath) else { return }
        for (key, value) in sourceDict {
            if let url: URL = URL(string: key as! String), let clazz = NSClassFromString(value as! String) as? URLReceivable.Type {
                let result = RouterManager.shared.register(url, clazz: clazz)
                print("\(result)")
            }
        }
        RouterManager.shared.register(URL(string: "/page/init")!) { (params) in
            print("\(params)")
        }
        let (params, handler) = RouterManager.shared.searchHandler(with: URL(string: "/page/init?name=haha")!)
        if let h = handler { h(params) }
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
       print("寻找文件地址")
        if let path = Bundle.main.path(forResource: "RouterMap", ofType: "plist") {
            register(contentPath: path)
        }
        return true
    }
}

class userContentController: NSObject, URLReceivable {
    
}

class executeController: URLReceivable {
    
}

class detailController: URLReceivable {
    
}
