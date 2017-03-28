//
//  SSFormTableView.swift
//  SSFormSwiftDemo
//
//  Created by Mac on 17/3/28.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit


/// 便于集成到工程中，降低耦合
class SSFormTableView: UIView,UITableViewDataSource,UITableViewDelegate,SSFormDescriptorDelegate,SSFormViewControllerDelegate {
    
    //MARK:-
    //MARK:properties
    var form:SSFormDescriptor! {
        didSet {
            form.delegate = self
        }
    }
    
    var tableView:UITableView = {
        let cusTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        return cusTableView
    }()
    
    var tableViewStyle:UITableViewStyle!
    
    //MARK:-
    //MARK:lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        let form:SSFormDescriptor = SSFormDescriptor.init("表格")
        self.form = form
        addSubview(self.tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:-
    //MARK:delegate&dataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if form.formSectionCount != 0 {
            return form.formSectionCount
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        assert(section <= (self.form.formSectionCount), "out of range")
        let section:SSFormSectionDescriptor = self.form.formSectionAt(section)
        return section.formRowsCount
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        assert(section <= (self.form.formSectionCount), "out of range")
        let section:SSFormSectionDescriptor = self.form.formSectionAt(section)
        return (section.height > 0) ? section.height : 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        assert(indexPath.section <= (self.form.formSectionCount), "out of range")
        let section:SSFormSectionDescriptor = self.form.formSectionAt(indexPath.section)
        let formRow:SSFormRowDescriptor = section.formRowsAt(indexPath.row)
        return formRow.height
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        assert(section <= (self.form.formSectionCount), "out of range")
        let section:SSFormSectionDescriptor = self.form.formSectionAt(section)
        return section.title
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowDescriptor:SSFormRowDescriptor = self.form.formRowAt(indexPath) else {
            return UITableViewCell.init()
        }
        self.update(rowDescriptor)
        return rowDescriptor.makeCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK:-
    //MARK:formDescriptorDelegate
    func formRowHasBeenAdded(_ formRow: SSFormRowDescriptor, At indexPath: IndexPath) {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: insertFormRow(formRow))
        self.tableView.endUpdates()
    }
    
    func formRowHasBeenRemoced(_ formRow: SSFormRowDescriptor, At indexPath: IndexPath) {
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [indexPath], with: deleteFormRow(formRow))
        self.tableView.endUpdates()
    }
    
    func formSectionHasBeenAdded(_ formSection: SSFormSectionDescriptor, At index:Int) {
        self.tableView.beginUpdates()
        self.tableView.insertSections(IndexSet.init(integer: index), with: insertFormSection(formSection))
        self.tableView.endUpdates()
    }
    
    func formSectionHasBeenRemoved(_ formSection: SSFormSectionDescriptor, At index:Int) {
        self.tableView.beginUpdates()
        self.tableView.deleteSections(IndexSet.init(integer: index), with: insertFormSection(formSection))
        self.tableView.endUpdates()
    }
    
    func formRowDescriptorValueHasChanged(_ formRow: SSFormRowDescriptor, oldValue: AnyObject, newValue: AnyObject) {
        self.update(formRow)
    }
    //MARK:-
    //MARK:SSFormViewControllerDelegate
    func insertFormRow(_ formRow: SSFormRowDescriptor) -> UITableViewRowAnimation {
        return .automatic
    }
    func deleteFormRow(_ formRow: SSFormRowDescriptor) -> UITableViewRowAnimation {
        return .automatic
    }
    func insertFormSection(_ formSection: SSFormSectionDescriptor) -> UITableViewRowAnimation {
        return .automatic
    }
    func deleteFormSection(_ formSection: SSFormSectionDescriptor) -> UITableViewRowAnimation {
        return .automatic
    }
    
    //MARK:-
    //MARK:helper
    @discardableResult func update(_ formRow:SSFormRowDescriptor) -> SSFormBaseCell {
        let cell:SSFormBaseCell = formRow.makeCell()
        self.configCell(cell)
        cell.setNeedsLayout()
        return cell
    }
    func configCell(_ cell:SSFormBaseCell) -> Void {
        cell.update()
    }
}
