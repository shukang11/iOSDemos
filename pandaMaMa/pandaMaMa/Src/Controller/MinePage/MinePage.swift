//
//  MinePage.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/17.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit

class MinePage: SYTableViewController {
    //MARK:property

    //MARK:lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor()
        if let bar = self.navigationController?.navigationBar {
            bar.setBackgroundcolorClean()
        }
        let attr = NSMutableAttributedString.init(string: "个人中心")
        attr.ss_color = UIColor.clear
        self.attributeTitle = attr
        self.createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    //MARK:delegate&dataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.tableView(tableView, numberOfRowsInSection:section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableData.tableView(tableView, heightForRowAt:indexPath)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let celldata = self.tableData[indexPath] {
            if celldata.cellType == "title_cell",
                let cell: TitleCell = tableView.dequeueReusableCell(withIdentifier: "title_cell") as? TitleCell {
                cell.titleLabel.textColor = UIColor.randomColor()
                cell.titleLabel.text = celldata.cellData as? String
                return cell
            }
            else if celldata.cellType == "header_cell",
                let cell: UserCenterHeaderCell = tableView.dequeueReusableCell(withIdentifier: "header_cell") as? UserCenterHeaderCell {
                cell.headerImageView.image = UIImage.init(named: "HomeModuleLogo.bundle/logo_recommend")
                return cell
            }
        }
         return UITableViewCell.init()
    }
    //MARK:customMethod
    private func createUI() {
        self.view.addSubview(self.tableView)
        self.tableView.register(TitleCell.self, forCellReuseIdentifier: "title_cell")
        self.tableView.register(UserCenterHeaderCell.self, forCellReuseIdentifier: "header_cell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.snp.bottomMargin)
        }
        self.tableData = self.prepareTableData()
        self.tableView.reloadData()
    }
    
    func prepareTableData() -> TableViewConvertTable {
        var table = TableViewConvertTable()
        var section = TableViewConvertSection()
        section.append({
            let c = TableViewConvertCell(cellType: "header_cell", cellHeight: CGFloat(220.pd_scale()), cellData: nil)
            return c
            }())
        section.append({
            let c = TableViewConvertCell(cellType: "title_cell", cellHeight: CGFloat(88.pd_scale()), cellData: "详细资料")
            return c
            }())
        table.append(section)
        return table
    }
}


