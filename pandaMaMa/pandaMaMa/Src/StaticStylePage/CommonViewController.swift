//
//  CommonViewController.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/24.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit
import SSKitSwift

typealias tableDataBlock = () -> [String : Any]

class CommonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK:-
    //MARK:properties
    
    //MARK:property
    var navigationHeight: CGFloat {// 获得导航栏的高度
        if let navigation = self.navigationController {
            return navigation.navigationBar.frame.height;
        }else { return 0.0; }
    }
    var hasLocolTabBar: Bool {// 当前界面是否有私有的tabbar控制条
        for v in self.view.subviews {
            if v.isKind(of: UITabBar.self) { return true }
        }
        return false
    }
    var tabBarHeight: CGFloat { // tabbar的高度，全局的和私有的不可同时出现
        var height: CGFloat = 0.0
        if (self.hasRootTabBar) {
            if let tabBarController: UITabBarController = self.tabBarController {
                height =  tabBarController.tabBar.frame.height
            }
        }else if (self.hasLocolTabBar) {
            for v in self.view.subviews {
                if v.isKind(of: UITabBar.self) {
                    height = v.bounds.height
                }
            }
        }
        return height
    }
    var hasRootTabBar: Bool {// 当前是否显示了跟tabbar控制条
        if let tabBarController: UITabBarController = self.tabBarController, let controller: UIViewController = tabBarController.selectedViewController {// 是导航控制器
            if let navi: UINavigationController = controller as? UINavigationController, let curPage: UIViewController = navi.topViewController {// 导航
                if curPage.hidesBottomBarWhenPushed == true { return false }
                return true
            }
            else if controller.presentedViewController != nil {
                return false
            }
            else if (controller.tabBarController?.tabBar.isHidden == true) {
                return false
            }
        }
        return false
    }
    lazy var tableView: UITableView = {
        let o = UITableView.tableView()
        o.delegate = self
        o.dataSource = self
        return o
    }()
    
    lazy var groupTableView: UITableView = {
        let o = UITableView.groupTableView()
        o.delegate = self
        o.dataSource = self
        return o
    }()
    
    override var title: String? { // 设置页面的标题
        get { return self.attributeTitle?.string }
        set {
            let o = NSAttributedString.init(string: newValue ?? "")
            attributeTitle = o
        }
    }
    var _attributeTitle: NSAttributedString? {
        didSet {
            let o: UILabel = UILabel.init()
            o.backgroundColor = UIColor.clear
            o.textAlignment = .center
            o.attributedText = _attributeTitle
            self.navigationItem.titleView = o
        }
    }
    
    var attributeTitle: NSAttributedString? {
        get { return _attributeTitle }
        set { _attributeTitle = newValue }
    }
    
    //MARK:-
    //MARK:lifeCycle
    override func loadView() {
        super.loadView()
//        self.view.isExclusiveTouch = true//设置界面的排他性，避免多个控件同时接受点击事件
        self.view.backgroundColor = UIColor.white
        self.commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let value:NSNumber = NSNumber.init(value: UIInterfaceOrientation.portrait.rawValue)
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    //MARK:-
    //MARK:delegate&dataSource
    //MARK:delegate&dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        assert(false, "please implement this method to adapt UITableViewDelegate&DataSource")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        assert(false, "please implement this method to adapt UITableViewDelegate&DataSource")
    }
    //MARK:-
    //MARK:http
    func handleResponse(response: [String : Any]?) -> Void {
        if let dictionary: [String: AnyObject] = response as [String : AnyObject]? {
            if let code: Int = dictionary["resultCode"] as? Int, let message: String = dictionary["resultMessage"] as? String {
                guard code != 1 else { return }
                DLog("\(message)")
            }
        }
    }

    //MARK:-
    //MARK:publicMethod
    public func controller() -> CommonViewController {
        return self
    }
    //MARK:-
    //MARK:helper
    func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func commonInit() -> Void {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
}

