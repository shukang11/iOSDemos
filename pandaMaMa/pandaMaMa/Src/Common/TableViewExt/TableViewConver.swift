//
//  TableViewConver.swift
//  pandaMaMa
//
//  Created by tree on 2018/1/31.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import UIKit

//MARK:-
//MARK:tableview相关
public let kTableViewSectionHeaderKey = "sectionHeader"// 区头
public let kTableViewSectionFooterKey = "sectionFooter"// 区头
public let kTableViewSectionCountKey = "sectionCound"// 区数
public let kTableViewNumberOfRowsKey = "numberOfRows"//行数

public let kTableViewCellListKey = "cellList"//行集合
public let kTableViewCellDataKey = "cellData"//行数据
public let kTableViewCellTypeKey = "cellStyle"//行样式
public let kTableViewCellHeightKey = "cellHeight"//行高


protocol DictionaryConvertAble {
    func asDict() -> [String: Any]
}

protocol ArrayConvertAble {
    func asArray() -> [Any]
}

fileprivate protocol TableResponseAble {
    // delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    
    // DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    func numberOfSections(in tableView: UITableView) -> Int
}

public struct TableViewConvertTable: ArrayConvertAble, TableResponseAble {
    
    private var sectionList: [TableViewConvertSection] = []
    
    var sectionCount: Int { return sectionList.count }
    
    // 会改变属性的值
    mutating func append(_ section: TableViewConvertSection) {
        self.sectionList.append(section)
    }
    
    func asArray() -> [Any] {
        var o = Array<Dictionary<String, Any>>()
        for section in self.sectionList {
            o.append(section.asDict())
        }
        return o
    }
    
    public subscript(_ indexPath: IndexPath) -> TableViewConvertCell? {
        let sect: TableViewConvertSection = self.sectionList[indexPath.section]
        return sect[indexPath.row]
    }
    
    /// TableResponseAble
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sect: TableViewConvertSection = self.sectionList[indexPath.section]
        if let row: TableViewConvertCell = sect[indexPath.row], let result = row.asDict()[kTableViewCellHeightKey] as? CGFloat {
            return result
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sect: TableViewConvertSection = self.sectionList[section]
        return sect.rowCount()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionList.count
    }
    
}


/// 区头区尾等
public struct TableViewConvertView: DictionaryConvertAble {
    
    var viewType: String = "UITableViewView"
    
    var viewHeight: Float = 44.0
    
    var viewData: Any? = nil
    
    func asDict() -> [String : Any] {
        var o = [String: Any]()
        o[kTableViewCellTypeKey] = viewType
        o[kTableViewCellHeightKey] = viewHeight
        if let data = viewData {
            o[kTableViewCellDataKey] = data
        }
        return o
    }
}

public struct TableViewConvertSection: DictionaryConvertAble {
    //MARK:-
    //MARK:properties
    private var cellList: [TableViewConvertCell] = []
    
    var sectionHeader: TableViewConvertView? = nil
    
    var sectionFooter: TableViewConvertView? = nil
    
    public mutating func append(_ cell: TableViewConvertCell) { cellList.append(cell) }
    
    public mutating func pop() -> TableViewConvertCell? {
        return cellList.popLast()
    }
    
    func rowCount() -> Int { return cellList.count }
    
    public subscript(_ row: Int) -> TableViewConvertCell? {
        return cellList[row]
    }
    
    func asDict() -> [String : Any] {
        var o = [String: Any]()
        if cellList.count > 0 {
            o[kTableViewCellListKey] = cellList.map({ (cell) -> [String: Any] in
                return cell.asDict()
            })
        }
        o[kTableViewNumberOfRowsKey] = cellList.count
        if let header = sectionHeader {
            o[kTableViewSectionHeaderKey] = header.asDict()
        }
        if let footer = sectionFooter {
            o[kTableViewSectionFooterKey] = footer.asDict()
        }
        return o
    }
}

public struct TableViewConvertCell: DictionaryConvertAble {
    //MARK:-
    //MARK:properties
    var cellType: String = "UITableViewCell"
    
    var cellHeight: CGFloat = 44.0
    
    var cellData: Any? = nil
    
    init(cellType: String, cellHeight: CGFloat, cellData: Any?) {
        self.cellType = cellType
        self.cellHeight = cellHeight
        self.cellData = cellData
    }
    
    func asDict() -> [String : Any] {
        var o = [String: Any]()
        o[kTableViewCellTypeKey] = self.cellType
        o[kTableViewCellHeightKey] = self.cellHeight
        if let data = cellData {
            o[kTableViewCellDataKey] = data
        }
        return o
    }
    
}


class TableViewConvertModule: NSObject, HookModuleProtocol {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        var table = TableViewConvertTable()
        
        let cell = TableViewConvertCell(cellType: "HomeType", cellHeight: CGFloat(44.0), cellData: nil)
        var section = TableViewConvertSection.init()
        section.append(cell)
        section.append(cell)
        table.append(section)
        print(section.asDict())
        print(table.asArray())
        return true
    }
}


