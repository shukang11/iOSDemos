//
//  MyPage.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/24.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit
class MyPage: CommonViewController {
    //MARK:property属性
    var mydelegate:Mydelegate = {
        return Mydelegate()
    }()
    //MARK:system系统
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        self.createMainUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    //MARK:delegate&dataSource代理和数据源
    //MARK:customMethod自定义
    func createMainUI() {
        view.addSubview(tableView)
        tableView.frame = CGRect.init(x: 0.0, y: 64.0, width: view.width, height: view.height - 64.0)
        tableView.delegate = mydelegate
        tableView.dataSource = mydelegate
        for index in 1...10 {
            mydelegate.models.append("\(index)行")
        }
    }
}
class Mydelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    //MARK:-
    //MARK:properties
    var models:[String] = []
    //MARK:-
    //MARK:delegate&dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSections")
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("heightForRowAt")
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt")
        var cell:demoCell? = tableView.dequeueReusableCell(withIdentifier: "cell") as! demoCell?
        if cell == nil {
            cell = demoCell.init(style: .value1, reuseIdentifier: "cell")
            cell?.selectionStyle = .none
        }
        cell?.contentView.debugModeColor()
        cell?.textLabel?.text = "\(indexPath)-->\(models[indexPath.row])"
        cell?.detailTextLabel?.text = "didSelectRowAtdidSelectRowAtdetail"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .right)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action:UITableViewRowAction = UITableViewRowAction.init(style: .default, title: "添加", handler:{
            (action, indexPath) in
            print("added")
        })
        action.backgroundColor = UIColor.randomColor()
        
        let ac:UITableViewRowAction = UITableViewRowAction.init(style: .default, title: "删除", handler:{
            (action, indexPath) in
            print("added")
        })
        ac.backgroundColor = UIColor.randomColor()
        return [action,ac]
    }
}
