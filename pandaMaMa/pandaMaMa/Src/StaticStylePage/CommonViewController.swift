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

class CommonViewController: UIViewController {
    //MARK:-
    //MARK:properties
    
    var navigationHeight: CGFloat {// 获得导航栏的高度
        if let navigation = self.navigationController {
            return navigation.navigationBar.frame.height
        }else { return 0.0 }
    }
    
    var navigationBar: UINavigationBar?
    var navigationView: UIView?
    
    var tableView:UITableView = {// 获得一个tableview
        return UITableView.tableView()
    }()
    
    private var tableview:UITableView = {
        let _tableView : UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        _tableView.indicatorStyle = .white
        _tableView.isScrollEnabled = true
        _tableView.isUserInteractionEnabled = true
        _tableView.backgroundColor = UIColor.clear
        _tableView.backgroundView = nil
        _tableView.tableFooterView = UIView.init()
        _tableView.sectionHeaderHeight = 0.0
        _tableView.sectionFooterHeight = 0.0
        _tableView.separatorStyle = .none
        return _tableView
    }()
    
    override var title: String? {// 设置页面的标题
        didSet{
            let _titleView:UILabel = UILabel.init()
            _titleView.textColor = UIColor.black_font()
            _titleView.backgroundColor = UIColor.clear
            _titleView.font = UIFont.naviTitleFont()
            _titleView.textAlignment = .center
            let frame:CGRect = _titleView.frame
            _titleView.frame = CGRect.init(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 34.0)
            self.navigationItem.titleView = _titleView
            _titleView.text = title
        }
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
        self.styleNavigationBar()
    }
    
    //MARK:-
    //MARK:delegate&dataSource
    
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
    func styleNavigationBar() {
        // 隐藏默认的导航条
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // 创建一个新的
        self.navigationView?.addSubview(self.navigationBar ?? UIView())
        self.view.addSubview(self.navigationView ?? UIView())
        // 添加一个item
        if let navigation = self.navigationController {
            if navigation.viewControllers.count > 1 {
                let back: UIBarButtonItem = UIBarButtonItem.init(title: "back", style: .plain, target: self, action: #selector(CommonViewController.popAction))
                back.tintColor = UIColor.black
                self.navigationItem.leftBarButtonItem = back
            }
        }
        self.navigationBar?.setItems([self.navigationItem], animated: true)
    }
    func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func commonInit() -> Void {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationBar = UINavigationBar.init(frame: CGRect.init(x: 0.0, y: 20.0, width: kScreenWidth, height: self.navigationHeight))
        self.navigationBar?.isTranslucent = false
        self.navigationView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: kScreenWidth, height: APPConstant.statusBarHeight + self.navigationHeight))
        self.navigationView?.backgroundColor = UIColor.white
    }
}
extension UITableView {
    class func tableView() -> UITableView {
        let _tableView : UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        _tableView.indicatorStyle = .white
        _tableView.isScrollEnabled = true
        _tableView.isUserInteractionEnabled = true
        _tableView.backgroundColor = UIColor.clear
        _tableView.backgroundView = nil
        _tableView.tableFooterView = UIView.init()
        
        _tableView.sectionHeaderHeight = 0.0
        _tableView.sectionFooterHeight = 0.0
        
        _tableView.separatorStyle = .singleLine
        return _tableView
    }
    
    class func groupTableView() -> UITableView {
        let _tableView : UITableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        _tableView.indicatorStyle = .white
        _tableView.isScrollEnabled = true
        _tableView.isUserInteractionEnabled = true
        _tableView.backgroundColor = UIColor.clear
        _tableView.backgroundView = nil
        _tableView.tableFooterView = UIView.init()
        
        _tableView.sectionHeaderHeight = 0.0
        _tableView.sectionFooterHeight = 0.0
        
        _tableView.separatorStyle = .singleLine
        return _tableView
    }
    
    func scrollToBottom() -> Void {
        let sectionCount:Int = (self.dataSource?.numberOfSections!(in: self))!
        let lastSectionRowCount:Int = (self.dataSource?.tableView(self, numberOfRowsInSection: sectionCount - 1))!
        
        let indexPath: IndexPath = IndexPath.init(row: lastSectionRowCount - 1, section: sectionCount - 1)
        self.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}


