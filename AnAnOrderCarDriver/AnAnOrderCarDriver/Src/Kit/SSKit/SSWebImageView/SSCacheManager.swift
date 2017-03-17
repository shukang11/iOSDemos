//
//  SSCacheManager.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/10/24.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
typealias SSFileCollections = [String : Data]
enum SSCachePosition {
    case Unkown
    case Disk
    case Menmory
}
class SSCacheManager: NSObject {
    static let sharedInstance = SSCacheManager()
    //MARK: properties
    open var filePosition: SSCachePosition = SSCachePosition.Unkown
    open var url: String?
    open var fileName: String?
    public var fileCacheMemory:SSFileCollections = [:]
    public var fileDirctoty : String = Path.caches.path+"/sscaches/"
    public let imageFileManager :FileManager = FileManager.default
    public var cache:[String: Data] = [:]
    
    override init() {
        
        super.init()
    }
    
    public func cachesFolderExsist() ->Bool {
        let isExsist = self.imageFileManager.fileExists(atPath: self.fileDirctoty)
        if isExsist == false {
            do {
                let created = try self.createCachesFolder(path: self.fileDirctoty)
                if created == false {return false}
            } catch {
                return false
            }
        }
        print("\(self.fileState("3d1e149f50962ab405c5b4646c108af5"))")
        return true
    }
    public func createCachesFolder(path:String) throws -> Bool {
        try Path.fileManager.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
        return true
    }
    /// 获得文件的数据
    ///
    /// - parameter url: 文件的网络地址
    public func getFile(_ url:String) ->Data? {
        let tempData = NSData.init(contentsOfFile: self.fileDirctoty+url)
        let data = tempData as? Data
        if data == nil {return nil}
        self.fileCacheMemory[url] = data
        return data
    }
    
    public func getCachesSize()->Float {
        let fileArray = self.imageFileManager.subpaths(atPath: self.fileDirctoty)
        var tempSize:Float = 0.0
        for fileName in fileArray! {
            do {
                let info:NSDictionary = try self.imageFileManager.attributesOfItem(atPath: self.fileDirctoty+fileName) as NSDictionary
                let size = Float(info.fileSize())
                tempSize += size
            } catch {
                return 0.0
            }
        }
        return tempSize
    }
    
    public func cleanAllCaches(clean:Bool) {
        if clean == false {return}
        try! self.imageFileManager.removeItem(atPath: self.fileDirctoty)
    }
    
    
    public func fileState(_ fileUrl:String)->SSCachePosition {
        var defaultPosition = SSCachePosition.Unkown
        if self.fileCacheMemory.count > 0 {
            for (fileName,_) in self.fileCacheMemory {
                if fileName == fileUrl {defaultPosition = .Menmory}
            }
        }
        
        let fileArray = self.imageFileManager.subpaths(atPath: self.fileDirctoty)
        for fileName in fileArray! {
            if fileName == fileUrl { defaultPosition = .Disk}
        }
        return defaultPosition
    }
}
