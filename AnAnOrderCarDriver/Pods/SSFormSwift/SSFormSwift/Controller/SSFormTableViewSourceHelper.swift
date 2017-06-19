//
//  SSFormTableViewSourceHelper.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/3/29.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit
///将用到的代理和数据源等剥离出来
open class SSFormTableViewSourceHelper: NSObject, UITableViewDelegate, UITableViewDataSource, SSFormDescriptorDelegate {
    //MARK:-
    //MARK:properties
    public var form:SSFormDescriptor! {
        didSet {
            form.delegate = self
        }
    }
    public var tableView:UITableView!
    //MARK:-
    //MARK:init
    
    public convenience init(_ tableView:UITableView) {
        self.init()
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.form = SSFormDescriptor.init()
        self.form.delegate = self
    }
    
    public convenience init(_ tableView:UITableView, form: SSFormDescriptor) {
        self.init()
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.form = form
        self.form.delegate = self
    }
    //MARK:-
    //MARK:dataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        if self.form.formSectionCount != 0 {
            return self.form.formSectionCount
        }
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        assert(section <= (self.form.formSectionCount), "out of range")
        let section:SSFormSectionDescriptor = self.form.formSectionAt(section)
        return section.formRowsCount
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        print("heightForHeaderInSection")
        assert(section <= (self.form.formSectionCount), "out of range")
        let section:SSFormSectionDescriptor = self.form.formSectionAt(section)
        return (section.height > 0) ? section.height : 0.01
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        print("heightForFooterInSection")
        return 0.01
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("heightForRowAt\(indexPath)")
        assert(indexPath.section <= (self.form.formSectionCount), "out of range")
        let section:SSFormSectionDescriptor = self.form.formSectionAt(indexPath.section)
        let formRow:SSFormRowDescriptor = section[indexPath.row]
        return formRow.height
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("titleForHeaderInSection")
        assert(section <= (self.form.formSectionCount), "out of range")
        let section:SSFormSectionDescriptor = self.form.formSectionAt(section)
        return section.title
    }
 
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt\(indexPath)")
        guard let rowDescriptor:SSFormRowDescriptor = self.form[indexPath] else {
            return UITableViewCell.init()
        }
        let cell:SSFormBaseCell
        cell = rowDescriptor.makeCell(tableView)!
        cell.rowDescriptor = rowDescriptor
        cell.update()
        return cell
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let formRow:SSFormRowDescriptor = form[indexPath] else { return false}
        print("canEditRowAt\(formRow.canEditRow)")
        return formRow.canEditRow
    }
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        guard let formRow:SSFormRowDescriptor = form[indexPath] else { return false}
        print("--->canMoveRowAt\(formRow.canMoveRow)")
        return formRow.canMoveRow
    }
    
    //编辑样式，如果想要使用滑动显示侧滑菜单，那么需要删除这个方法
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        guard let formRow:SSFormRowDescriptor = form[indexPath] else { return .none}
        print("editingStyleForRowAt--->\(formRow.editingStyle)")
        return formRow.editingStyle
    }
    
    //MARK:-
    //MARK:delegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt\(indexPath)")
        let cell:SSFormBaseCell = tableView.cellForRow(at: indexPath) as! SSFormBaseCell
        guard cell.rowDescriptor != nil else { return}
        let formRow:SSFormRowDescriptor = cell.rowDescriptor!
        
        if ((formRow.onClickedBlock) != nil) {
            formRow.onClickedBlock!(formRow,indexPath)
        }
    }
    
    ///编辑状态下的代理方法
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let formRow:SSFormRowDescriptor = form[indexPath] else { return}
        print("commit editingStyle")
        if formRow.editingStyleHandle != nil {
            formRow.editingStyleHandle!(formRow, editingStyle, indexPath)
        }else {
            switch editingStyle {
            case .none:
                break
            case .insert:
                guard let addRow:SSFormRowDescriptor = formRow.addFormRow else { break}
                guard let index = formRow.sectionDescriptor?.rowIndexOf(formRow) else { break}
                formRow.sectionDescriptor?.add(addRow, At: index + 1)
                break
            case .delete:
                formRow.removeFromSection()
                break
            }
        }
    }
    
    ///删除按钮的文字
    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        let cell:SSFormBaseCell = tableView.cellForRow(at: indexPath) as! SSFormBaseCell
        guard cell.rowDescriptor != nil else { return nil}
        return cell.rowDescriptor?.titleForDeleteConfirmationButton
    }
    
    /*
    ///编辑状态下侧滑返回的几个响应的集合,如果想要执行这个方法，那么必须将editingStyleForRowAt方法删除掉
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        print("editActionsForRowAt")
        let cell:SSFormBaseCell = tableView.cellForRow(at: indexPath) as! SSFormBaseCell
        guard cell.rowDescriptor != nil else { return nil}
        return cell.rowDescriptor?.editActions
    }
    */
    /// 移动的代理方法
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        form.exchangeFormRow(sourceIndexPath, to: destinationIndexPath)
    }
    
    
    //MARK:-
    //MARK:formDescriptorDelegate
    public func formRowHasBeenAdded(_ formRow: SSFormRowDescriptor, At indexPath: IndexPath) {
        print("formRowHasBeenAdded\(indexPath)")
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: insertFormRow(formRow))
        self.tableView.endUpdates()
    }
    
    public func formRowHasBeenRemoced(_ formRow: SSFormRowDescriptor, At indexPath: IndexPath) {
        print("formRowHasBeenRemoced\(indexPath)")
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [indexPath], with: deleteFormRow(formRow))
        self.tableView.endUpdates()
    }
    
    public func formSectionHasBeenAdded(_ formSection: SSFormSectionDescriptor, At index:Int) {
        print("formSectionHasBeenAdded")
        self.tableView.beginUpdates()
        self.tableView.insertSections(IndexSet.init(integer: index), with: insertFormSection(formSection))
        self.tableView.endUpdates()
    }
    
    public func formSectionHasBeenRemoved(_ formSection: SSFormSectionDescriptor, At index:Int) {
        print("formSectionHasBeenRemoved")
        self.tableView.beginUpdates()
        self.tableView.deleteSections(IndexSet.init(integer: index), with: insertFormSection(formSection))
        self.tableView.endUpdates()
    }
    
    public func formRowDescriptorValueHasChanged(_ formRow: SSFormRowDescriptor, newValue: AnyObject) {
        print("formRowDescriptorValueHasChanged")
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [form.indexPathOf(formRow)!], with: formRow.freshAnimation)
        formRow.cell?.update()
        self.tableView.endUpdates()
    }
    //MARK:-
    //MARK:SSFormViewControllerDelegate
    func insertFormRow(_ formRow: SSFormRowDescriptor) -> UITableViewRowAnimation {
        return formRow.insertAnimation
    }
    func deleteFormRow(_ formRow: SSFormRowDescriptor) -> UITableViewRowAnimation {
        return formRow.deleteAnimation
    }
    func insertFormSection(_ formSection: SSFormSectionDescriptor) -> UITableViewRowAnimation {
        return formSection.insertAnimation
    }
    func deleteFormSection(_ formSection: SSFormSectionDescriptor) -> UITableViewRowAnimation {
        return formSection.deleteAnimation
    }
    
    //MARK:-
    //MARK:helper
    func update(_ formRow:SSFormRowDescriptor) -> Void {
        /// 在这里不能放刷新操作，会造成循环引用
        guard let cell:SSFormBaseCell = formRow.cell else {
            return
        }
        self.configCell(cell)
        cell.setNeedsLayout()
        print("\(cell)\([form.indexPathOf(formRow)!])")
    }
    func configCell(_ cell:SSFormBaseCell) -> Void {
        cell.update()
    }
    
    //MARK:-
    //MARK:runtime_Helper
}

private var sourceHelperKey: UInt = 0
extension UITableView {
    public var sourceHelper: SSFormTableViewSourceHelper? {
        get {
            return objc_getAssociatedObject(self, &sourceHelperKey) as? SSFormTableViewSourceHelper
        }
        set(newValue) {
            objc_setAssociatedObject(self, &sourceHelperKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
