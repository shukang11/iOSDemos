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
    var title:String = ""
    public var formSectionCount:Int {
        return self.formSections.count
    }
    private dynamic var formSections:[SSFormSectionDescriptor] = []
    var delegate:SSFormDescriptorDelegate?
    //MARK:-
    //MARK:lifeCycle

    override init() {
        super.init()
        self.addObserver(self, forKeyPath: "formSections", options: [.new,.old], context: &myContext)
    }
    
    init(_ title:String) {
        super.init()
        self.title = title
        self.addObserver(self, forKeyPath: "formSections", options: [.new,.old], context: &myContext)
    }
    deinit {
        self.removeObserver(self, forKeyPath: "formSections")
    }
    //MARK:-
    //MARK:delegate
    
    //MARK:-
    //MARK:KVC
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
    }
    //MARK:-
    //MARK:public
    public func addSection(_ formSection:SSFormSectionDescriptor) -> Void {
        addSection(formSection, At: self.formSections.count)
    }
    
    public func addSection(_ formSection:SSFormSectionDescriptor, At index:Int) -> Void {
        ss_addSection(formSection, At: index)
    }
    
    private func ss_addSection(_ formSection:SSFormSectionDescriptor, At index:Int) ->Void {
        formSection.formDescriptor = self;
        self.formSections.insert(formSection, at: index)
        guard (self.delegate != nil) && self.formSections.contains(formSection) else { return}
        self.delegate?.formSectionHasBeenAdded(formSection, At: index)
    }
    
    public func removeSection(_ formSection:SSFormSectionDescriptor) -> Void {
        let index:Int = self.formSections.index(of: formSection)!
        ss_removeSection(formSection, At: index)
    }
    
    public func removeSection(At index:Int) -> Void {
        let formSection:SSFormSectionDescriptor = self.formSections[index]
        ss_removeSection(formSection, At: index)
    }
    
    public func ss_removeSection(_ formSection:SSFormSectionDescriptor, At index:Int) -> Void {
        self.formSections.remove(at: index)
        guard (self.delegate != nil) && self.formSections.contains(formSection) == false else { return}
        self.delegate?.formSectionHasBeenRemoved(formSection, At: index)
    }
    
    public func formRowAt(_ indexPath:IndexPath) -> SSFormRowDescriptor? {
        if (self.formSections.count > indexPath.section)&&(self.formSections[indexPath.section].formRowsCount > indexPath.row) {
            return self.formSections[indexPath.section].formRowsAt(indexPath.row)
        }
        return nil
    }
    //MARK:-
    //MARK:helper

    public func containFormSection(_ formSection:SSFormSectionDescriptor) -> Bool {
        guard self.formSections.contains(formSection) == true else {
            return false
        }
        return true
    }
    
    public func formSectionAt(_ index:Int) -> SSFormSectionDescriptor {
        assert(index < self.formSectionCount, "out of range")
        return self.formSections[index]
    }
    
    public func index(_ formSection:SSFormSectionDescriptor) -> Int {
        return self.formSections.index(of: formSection)!
    }

}
