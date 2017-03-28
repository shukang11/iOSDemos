//
//  CommonViewController.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/24.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

class CommonViewController: UIViewController {
    //MARK:-
    //MARK:properties
    let tableView:UITableView = {
        return UITableView.tableView()
    }()
    
    var formView: SSFormTableView!
    /// 设置页面的标题
    override var title: String? {
        didSet{
            let _titleView:UILabel = UILabel.init()
            _titleView.textColor = UIColor.color("0x313131")
            _titleView.backgroundColor = UIColor.clear
            _titleView.font = UIFont.systemFont(ofSize: 19.0)
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
        self.view.isExclusiveTouch = true//设置界面的排他性，避免多个控件同时接受点击事件
        self.view.backgroundColor = UIColor.white
    }
    
    //MARK:-
    //MARK:delegate&dataSource
    
    
    //MARK:-
    //MARK:publicMethod
    public func controller() -> CommonViewController {
        return self
    }
    //MARK:-
    //MARK:helper
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
