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

class SSFormRowDescriptor: NSObject {
    dynamic var value:AnyObject!
    var cellClassString:String = ""
    var height : CGFloat
    var cell:SSFormBaseCell?
    var cellConfig:[String:AnyObject]?
    var sectionDescriptor:SSFormSectionDescriptor?
    var delegate:AnyObject?
    
    
    init(_ height:CGFloat,cellClassString:String, value:AnyObject) {
        self.height = height
        self.cellClassString = cellClassString
        self.value = value
        super.init()
        self.addObserver(self, forKeyPath: "value", options: [.new,.old], context: &myContext)
    }
    //MARK:-
    //MARK:hepler
    public func makeCell(_ formViewController: SSFormViewController) -> SSFormBaseCell {
        if self.cell == nil {
            let className = self.cellClassString.getClassString()
            let cls:AnyClass = NSClassFromString(className)!
            assert(cls.isSubclass(of: SSFormBaseCell.self), "class must be the subClass of SSFormBaseCell")
            if let cellClass = cls as? SSFormBaseCell.Type {
                
                let obj:SSFormBaseCell = cellClass.init()
                self.cell = obj
                self.cell?.rowDescriptor = self
            }
        }
        return self.cell!
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
