//
//  SSFormDescriptorDelegate.swift
//  SSFormSwiftDemo
//
//  Created by Mac on 17/3/7.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

protocol SSFormDescriptorDelegate {
    
    func formSectionHasBeenRemoved(_ formSection:SSFormSectionDescriptor, At index:Int) -> Void
    
    func formSectionHasBeenAdded(_ formSection:SSFormSectionDescriptor, At index:Int) -> Void
    
    func formRowHasBeenAdded(_ formRow:SSFormRowDescriptor, At indexPath:IndexPath) -> Void
    
    func formRowHasBeenRemoced(_ formRow:SSFormRowDescriptor, At indexPath:IndexPath) -> Void
    
    func formRowDescriptorValueHasChanged(_ formRow:SSFormRowDescriptor, oldValue:AnyObject, newValue:AnyObject) -> Void
}
