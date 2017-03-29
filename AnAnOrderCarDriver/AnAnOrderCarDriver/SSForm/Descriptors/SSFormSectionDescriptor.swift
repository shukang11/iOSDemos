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
    var title:String = ""
    var height:CGFloat = 0.0
    private dynamic var formRows:[SSFormRowDescriptor] = []
    public var formRowsCount:Int {
        return self.formRows.count
    }
    var formDescriptor:SSFormDescriptor?
    
    
    var insertAnimation:UITableViewRowAnimation = .automatic
    var deleteAnimation:UITableViewRowAnimation = .automatic
    //MARK:-
    //MARK:lifeCycle
    
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
    
    //MARK:-
    //MARK:helper

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
    
    
    public func add(_ formRow:SSFormRowDescriptor) {
        add(formRow, At: self.formRows.count)
    }
    public func add(_ formRow:SSFormRowDescriptor, At index:Int) -> Void {
        ss_add(formRow, At: index)
    }
    
    private func ss_add(_ formRow:SSFormRowDescriptor, At index:Int) -> Void {
        formRow.sectionDescriptor = self
        self.formRows.insert(formRow, at: index)
        guard self.formDescriptor?.delegate != nil && (self.formDescriptor?.containFormSection(self))! else { return}
        let sectionIndex:Int = (self.formDescriptor?.index(self))!
        self.formDescriptor?.delegate?.formRowHasBeenAdded(formRow, At: IndexPath.init(row: index, section: sectionIndex))
    }
    
    public func removeAt(_ index:Int) -> Void {
        guard index < self.formRows.count else { return}
        let formRow:SSFormRowDescriptor = self.formRows[index]
        ss_removeRow(formRow, At: index)
    }
    public func removeRow(_ formRow:SSFormRowDescriptor) -> Void {
        let index:Int = self.formRows.index(of: formRow)!
        guard index < self.formRows.count else { return}
        ss_removeRow(formRow, At: index)
    }
    
    private func ss_removeRow(_ formRow:SSFormRowDescriptor, At index:Int) -> Void {
        self.formRows.remove(at: index)
        guard self.formDescriptor?.delegate != nil else { return}
        let sectionIndex:Int = (self.formDescriptor?.index(self))!
        self.formDescriptor?.delegate?.formRowHasBeenRemoced(formRow, At: IndexPath.init(row: index, section: sectionIndex))
    }
    
    public func formRowsAt(_ index:Int) -> SSFormRowDescriptor {
        return self.formRows[index]
    }
}
