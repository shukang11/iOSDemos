//
//  SSFormRowDescriptor.swift
//  SSFormSwiftDemo
//
//  Created by Mac on 17/3/7.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

private var myContext = 0
typealias OnClickedBlock = (_ formRow:SSFormRowDescriptor) -> Void

class SSFormRowDescriptor: NSObject {
    
    dynamic var value:AnyObject!
    
    var cellClassString:String = ""
    
    var height : CGFloat
    
    var cell:SSFormBaseCell?
    
    var cellClass:SSFormBaseCell.Type
    
    var cellConfig:[String:AnyObject]?
    
    var sectionDescriptor:SSFormSectionDescriptor?
    
    var delegate:AnyObject?
    
    var canEditRow:Bool = false
    
    var onClickedBlock:OnClickedBlock?
    
    var insertAnimation:UITableViewRowAnimation = .automatic
    
    var deleteAnimation:UITableViewRowAnimation = .automatic
    
    init(_ height:CGFloat,cellClass:SSFormBaseCell.Type, value:AnyObject) {
        self.height = height
        self.cellClass = cellClass
        self.value = value
        super.init()
        self.addObserver(self, forKeyPath: "value", options: [.new,.old], context: &myContext)
    }
    //MARK:-
    //MARK:public
    public func removeFromSection() -> Void {
        self.sectionDescriptor?.removeRow(self)
    }
    
    public func addToSection(_ toSection: SSFormSectionDescriptor) -> Void {
        toSection.add(self)
    }
    
    //MARK:-
    //MARK:hepler
    public func makeCell() -> SSFormBaseCell {
        if self.cell == nil {
            let obj:SSFormBaseCell = cellClass.init()
            self.cell = obj
            self.cell?.rowDescriptor = self

        }
        return self.cell!
    }
    public func onClickHandle(_ clicked: @escaping OnClickedBlock) -> Void {
        self.onClickedBlock = clicked
    }
    //MARK:-
    //MARK:KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if self.sectionDescriptor == nil { return}
        if (object as AnyObject).isEqual(self) && keyPath=="value" {
            let newValue:AnyObject = change![.newKey] as AnyObject
            let oldValue:AnyObject = change![.oldKey] as AnyObject
            self.sectionDescriptor?.formDescriptor?.delegate?.formRowDescriptorValueHasChanged(object as! SSFormRowDescriptor, oldValue: oldValue, newValue: newValue)
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "value")
    }
    
}
