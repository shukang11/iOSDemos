//
//  SSFormDescriptor.swift
//  SSFormSwiftDemo
//
//  Created by Mac on 17/3/7.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

private var myContext = 0
class SSFormDescriptor: NSObject {
    
    //MARK:-
    //MARK:properties
    
    /// 表名
    var title:String = ""
    
    /// 获得区的数量
    public var formSectionCount:Int {
        return self.formSections.count
    }
    
    /// 【私有变量】
    private dynamic var formSections:[SSFormSectionDescriptor] = []
    var delegate:SSFormDescriptorDelegate?
    //MARK:-
    //MARK:lifeCycle

    /// 初始化
    override init() {
        super.init()
        self.addObserver(self, forKeyPath: "formSections", options: [.new,.old], context: &myContext)
    }
    
    /// 初始化
    ///
    /// - Parameter title: 表名
    init(_ title:String) {
        super.init()
        self.title = title
        self.addObserver(self, forKeyPath: "formSections", options: [.new,.old], context: &myContext)
    }
    deinit {
        self.removeObserver(self, forKeyPath: "formSections")
    }
    //MARK:-
    //private
    
    /// 【私有方法】
    ///
    /// - Parameters:
    ///   - formSection: 区的描述对象
    ///   - index: 索引
    private func ss_addSection(_ formSection:SSFormSectionDescriptor, At index:Int) ->Void {
        formSection.formDescriptor = self;
        self.formSections.insert(formSection, at: index)
        guard (self.delegate != nil) && self.formSections.contains(formSection) else { return}
        self.delegate?.formSectionHasBeenAdded(formSection, At: index)
    }
    
    /// 【私有方法】
    ///
    /// - Parameters:
    ///   - formSection: 区的描述对象
    ///   - index: 索引
    private func ss_removeSection(_ formSection:SSFormSectionDescriptor, At index:Int) -> Void {
        self.formSections.remove(at: index)
        guard (self.delegate != nil) && self.formSections.contains(formSection) == false else { return}
        self.delegate?.formSectionHasBeenRemoved(formSection, At: index)
    }
    
    
    //MARK:-
    //MARK:KVC
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
    }
    
    //MARK:-
    //MARK:public
    
    /// 添加区描述对象
    ///
    /// - Parameter formSection: 区的描述对象
    public func addSection(_ formSection:SSFormSectionDescriptor) -> Void {
        addSection(formSection, At: self.formSections.count)
    }
    
    /// 添加区描述对象
    ///
    /// - Parameters:
    ///   - formSection: 区的描述对象
    ///   - index: 索引号
    public func addSection(_ formSection:SSFormSectionDescriptor, At index:Int) -> Void {
        ss_addSection(formSection, At: index)
    }
    
    /// 移除区
    ///
    /// - Parameter formSection: 区的描述对象
    public func removeSection(_ formSection:SSFormSectionDescriptor) -> Void {
        let index:Int = self.formSections.index(of: formSection)!
        ss_removeSection(formSection, At: index)
    }
    
    /// 根据索引移除区
    ///
    /// - Parameter index: 索引
    public func removeSection(At index:Int) -> Void {
        let formSection:SSFormSectionDescriptor = self.formSections[index]
        ss_removeSection(formSection, At: index)
    }
    
    /// 根据索引返回单元格的描述对象
    ///
    /// - Parameter indexPath: indexPath对象
    /// - Returns: 单元格的描述对象
    public subscript(indexPath:IndexPath) -> SSFormRowDescriptor? {
        if (self.formSections.count > indexPath.section)&&(self.formSections[indexPath.section].formRowsCount > indexPath.row) {
            return self.formSections[indexPath.section][indexPath.row]
        }
        return nil
    }
    
    func indexPathOf(_ formRow:SSFormRowDescriptor) -> IndexPath? {
        guard formSections.contains(formRow.sectionDescriptor!) == true else {
            return nil
        }
        assert(formRow.sectionDescriptor != nil, "formRow.sectionDescriptor cant be nil")
        let indexPath:IndexPath = IndexPath.init(row: (formRow.sectionDescriptor?.rowIndexOf(formRow))!, section: self.sectionIndexOf(formRow.sectionDescriptor!)!)
        return indexPath
    }
    
    /// 返回区的索引
    ///
    /// - Parameter formSection: 区的描述对象
    /// - Returns: 索引
    public func sectionIndexOf(_ formSection:SSFormSectionDescriptor) -> Int? {
        if formSections.contains(formSection) == true {
            return formSections.index(of: formSection)
        }
        return nil
    }
    
    /// 交换两个单位
    ///
    /// - Parameters:
    ///   - moveAt: 源地址
    ///   - to: 目标地址
    public func exchangeFormRow(_ moveAt: IndexPath, to: IndexPath) -> Void {
        guard let sourceDes = self[moveAt], let toDes = self[to] else { return}
        self.formSections[moveAt.section].replaceRow(toDes, At: moveAt.row)
        self.formSections[to.section].replaceRow(sourceDes, At: to.row)
    }
    //MARK:-
    //MARK:helper

    /// 是否包含一个区对象
    ///
    /// - Parameter formSection: 区的描述对象
    /// - Returns: 包含->true 不包含->false
    public func containFormSection(_ formSection:SSFormSectionDescriptor) -> Bool {
        guard self.formSections.contains(formSection) == true else {
            return false
        }
        return true
    }
    
    /// 根据索引返回区对象
    ///
    /// - Parameter index: 索引号
    /// - Returns: 区的描述对象
    public func formSectionAt(_ index:Int) -> SSFormSectionDescriptor {
        assert(index < self.formSectionCount, "out of range <<<index:\(index);self.formSectionCount:\(self.formSectionCount)>>>")
        return self.formSections[index]
    }
    
    /// 区的描述对象的索引号
    ///
    /// - Parameter formSection: 区的描述对象
    /// - Returns: 索引号
    public func index(_ formSection:SSFormSectionDescriptor) -> Int {
        return self.formSections.index(of: formSection)!
    }

}
