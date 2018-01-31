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
public struct TableViewConvertTable: ArrayConvertAble {
    
    public var sectionList = [TableViewConvertSection]()
    
    var sectionCount: Int { return sectionList.count }
    
    mutating func append(section: TableViewConvertSection) {
        self.sectionList.append(section)
    }
    
    func asArray() -> [Any] {
        var o = Array<Dictionary<String, Any>>()
        for section in self.sectionList {
            o.append(section.asDict())
        }
        return o
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
    
    var  sectionHeader: TableViewConvertView? = nil
    
    var sectionFooter: TableViewConvertView? = nil
    
    public mutating func append(cell: TableViewConvertCell) { cellList.append(cell) }
    
    public mutating func pop() -> TableViewConvertCell? {
        return cellList.popLast()
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
    
    var cellHeight: Float = 44.0
    
    var cellData: Any? = nil
    
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
        
        let cell = TableViewConvertCell(cellType: "HomeType", cellHeight: Float(44.0), cellData: nil)
        var section = TableViewConvertSection.init()
        section.append(cell: cell)
        section.append(cell: cell)
        table.append(section: section)
        print(section.asDict())
        print(table.asArray())
        return true
    }
}


