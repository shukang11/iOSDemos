//
//  SSFormSectionDescriptor.swift
//  SSFormSwiftDemo
//
//  Created by Mac on 17/3/7.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

private var myContext = 0

class SSFormSectionDescriptor: NSObject {
    //MARK:-
    //MARK:property
    
    /// 区头的文字
    var title:String?
    
    /// 区头的高度
    var height:CGFloat = 0.0
    
    /// 包含的所有的单元格描述对象
    private dynamic var formRows:[SSFormRowDescriptor] = []
    public var formRowsCount:Int {
        return self.formRows.count
    }
    
    /// 表格的描述对象
    var formDescriptor:SSFormDescriptor?
    
    /// 区的添加动画类型
    var insertAnimation:UITableViewRowAnimation = .automatic
    /// 区的删除动画类型
    var deleteAnimation:UITableViewRowAnimation = .automatic
    
    /// 区的刷新动画类型
    var freshAnimation:UITableViewRowAnimation = .automatic
    
    //MARK:-
    //MARK:lifeCycle
    
    /// 初始化方法
    ///
    /// - Parameter title: 区头的标题
    init(_ title:String) {
        super.init()
        self.title = title
        self.addObserver(self, forKeyPath: "formRows", options: [.new,.old], context: &myContext)
    }
    
    
    deinit {
        self.removeObserver(self, forKeyPath: "formRows")
    }
    //MARK:-
    //MARK:delegate
    
    //MARK:-
    //MARK:public
    
    /// 添加单元格
    ///
    /// - Parameter formRow: 单元格描述对象
    public func add(_ formRow:SSFormRowDescriptor) {
        add(formRow, At: self.formRows.count)
    }
    
    /// 根据索引添加单元格
    ///
    /// - Parameters:
    ///   - formRow: 单元格描述对象
    ///   - index: 索引
    public func add(_ formRow:SSFormRowDescriptor, At index:Int) -> Void {
        ss_add(formRow, At: index)
    }
    
    /// 根据索引移除一行单元格
    ///
    /// - Parameter index: 索引号
    public func removeAt(_ index:Int) -> Void {
        guard index < self.formRows.count else { return}
        let formRow:SSFormRowDescriptor = self.formRows[index]
        ss_removeRow(formRow, At: index)
    }
    
    /// 移除一个单元格对象
    ///
    /// - Parameter formRow: 单元格描述对象
    public func removeRow(_ formRow:SSFormRowDescriptor) -> Void {
        let index:Int = self.formRows.index(of: formRow)!
        guard index < self.formRows.count else { return}
        ss_removeRow(formRow, At: index)
    }
    
    /// 根据序列号替换一个元素
    ///
    /// - Parameters:
    ///   - formRow: 替换的源元素
    ///   - index: 目标的索引
    func replaceRow(_ formRow:SSFormRowDescriptor, At index:Int) -> Void {
        ss_replaceRow(formRow, At: index)
    }
    
    /// 根据索引获得单元格的描述对象
    ///
    /// - Parameter index: 索引
    /// - Returns: 单元格的描述对象
    public subscript(index:Int) -> SSFormRowDescriptor {
        return self.formRows[index]
    }
    
    /// 返回一个单元格对象在集合中的索引
    ///
    /// - Parameter formRow: 单元格的描述对象
    /// - Returns: 索引号，如果没有找到就返回nil
    func rowIndexOf(_ formRow:SSFormRowDescriptor) -> Int? {
        if (formRows.contains(formRow) == true) {
            return formRows.index(of: formRow)
        }
        return nil
    }
    //MARK:-
    //MARK:helper
    
    /// 【私有方法】添加描述对象到索引号中，并将自己赋值到其中
    ///
    /// - Parameters:
    ///   - formRow: 单元格的描述对象
    ///   - index: 索引号
    private func ss_add(_ formRow:SSFormRowDescriptor, At index:Int) -> Void {
        formRow.sectionDescriptor = self
        self.formRows.insert(formRow, at: index)
        guard self.formDescriptor?.delegate != nil && (self.formDescriptor?.containFormSection(self))! else { return}
        let sectionIndex:Int = (self.formDescriptor?.index(self))!
        self.formDescriptor?.delegate?.formRowHasBeenAdded(formRow, At: IndexPath.init(row: index, section: sectionIndex))
    }
    
    /// 【私有方法】根据索引号移除单元格的描述对象
    ///
    /// - Parameters:
    ///   - formRow: 移除的描述对象
    ///   - index: 索引
    private func ss_removeRow(_ formRow:SSFormRowDescriptor, At index:Int) -> Void {
        self.formRows.remove(at: index)
        guard self.formDescriptor?.delegate != nil else { return}
        let sectionIndex:Int = (self.formDescriptor?.index(self))!
        self.formDescriptor?.delegate?.formRowHasBeenRemoced(formRow, At: IndexPath.init(row: index, section: sectionIndex))
    }
    
    /// 【私有方法】根据序列号替换一个元素
    ///
    /// - Parameters:
    ///   - formRow: 替换的源元素
    ///   - index: 目标的索引
    private func ss_replaceRow(_ formRow:SSFormRowDescriptor, At index:Int) -> Void {
        guard index < formRows.count else { return}
        formRows[index] = formRow
    }
    
    //MARK:-
    //MARK:KVC
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        /*
        if self.formDescriptor?.delegate == nil { return}
        guard keyPath == "formRows" else { return}
        if self.formDescriptor?.formSections.contains(self) == false { return}
        
        if let changeKindValue = change?[.kindKey] as? UInt, let changeType = NSKeyValueChange(rawValue: changeKindValue) {
            switch changeType {
            case .setting:
                print("Setting")
                
                break
            case .insertion:
                print("insertion")
                /*
                let indexSet:IndexSet = change?[.indexesKey] as! IndexSet
                let formRow:SSFormRowDescriptor = (object as! SSFormSectionDescriptor).formRows[indexSet.first!]
                let sectionIndex:Int = (self.formDescriptor?.formSections.index(of: self))!
                self.formDescriptor?.delegate?.formRowHasBeenAdded(formRow, At: IndexPath.init(row: indexSet.first!, section: sectionIndex))
                 */
                break
            case .removal:
                print("removal")
                /*
                let indexSet:IndexSet = change?[.indexesKey] as! IndexSet
                let removedRow:SSFormRowDescriptor = (change?[.oldKey] as! [SSFormRowDescriptor])[0]
                let sectionIndex:Int = (self.formDescriptor?.formSections.index(of: self))!
                self.formDescriptor?.delegate?.formRowHasBeenRemoced(removedRow, At: IndexPath.init(row: indexSet.first!, section: sectionIndex))
                */
                break
            case .replacement:
                print("Replacement")
                break
            }
        }
 */
    }
    
    
    
}
