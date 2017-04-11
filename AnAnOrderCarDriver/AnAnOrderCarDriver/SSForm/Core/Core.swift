//
//  Core.swift
//  AnAnOrderCarDriver
//
//  Created by Mac on 17/4/11.
//  Copyright © 2017年 treee. All rights reserved.
//

import Foundation
import UIKit

internal class RowDefaults {
    static var cellUpdate = [String: (BaseCell, BaseRow) -> Void]()
    static var cellSetup = [String: (BaseCell, BaseRow) -> Void]()
    static var onCellHighlightChange = [String: (BaseCell, BaseRow) -> Void]()
    static var rowInitialization = [String: (BaseRow) -> Void]()
    static var onRowValidationChanged = [String: (BaseCell, BaseRow) -> Void]()
    static var rawCellUpdate = [String: Any]()
    static var rawCellSetup = [String: Any]()
    static var rawOnCellHighlightChanged = [String: Any]()
    static var rawRowInitialization = [String: Any]()
    static var rawOnRowValidationChanged = [String: Any]()
}

/// 一个cell的生产
public struct CellProvider<Cell: BaseCell> where Cell: CellType {
    public private (set) var nibName: String?
    
    public private (set) var bundle: Bundle!
    
    public init() {}
    
    public init(nibName: String, bundle: Bundle? = nil) {
        self.nibName = nibName
        self.bundle = bundle ?? Bundle(for: Cell.self)
    }
    
    func makeCell(style: UITableViewCellStyle) -> Cell {
        if let nibName = self.nibName {
            return bundle.loadNibNamed(nibName, owner: nil, options: nil)!.first as! Cell
        }
        return Cell.init(style: style, reuseIdentifier: nil)
    }
}
