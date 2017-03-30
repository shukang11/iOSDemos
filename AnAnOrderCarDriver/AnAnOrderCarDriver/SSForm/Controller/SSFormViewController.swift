//
//  SSFormViewController.swift
//  SSFormSwiftDemo
//
//  Created by Mac on 17/3/7.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

class SSFormViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SSFormDescriptorDelegate {
    //MARK:-
    //MARK:properties
    var form:SSFormDescriptor = {
        let form = SSFormDescriptor.init()
        return form
    }()
    var tableView:UITableView = {
        let cusTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        return cusTableView
    }()
    var tableViewStyle:UITableViewStyle!
    
    //MARK:-
    //MARK:lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.frame = self.view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.form.delegate = self;
        self.title = self.form.title
    }
    
    //MARK:-
    //MARK:delegate&dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.form.formSectionCount != 0 {
            return self.form.formSectionCount
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
   
    func formRowDescriptorValueHasChanged(_ formRow: SSFormRowDescriptor,  newValue: AnyObject) {
        self.update(formRow)
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
