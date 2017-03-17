//
//  SSURLDownload.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/10/24.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit
protocol SSURLDownloadDelegate {
    func wancheng(_ image : UIImage)
}

class SSURLDownload: NSObject,URLSessionDelegate,URLSessionDownloadDelegate {
    

    //MARK: properties
    static let shareDownloader = SSURLDownload()
    let configration : URLSessionConfiguration
    open var session : URLSession?
    public let delegate : SSURLDownloadDelegate?
    //MARK: functions
    override init() {
        self.configration = URLSessionConfiguration.default
        self.session = nil
        self.delegate = nil
        super.init()
    }
    
    public func download(_ urlRequest:URLRequest) {
        self.session = URLSession.init(configuration: self.configration, delegate: self, delegateQueue: nil)
        let downloadTask = self.session?.downloadTask(with: urlRequest)
        downloadTask?.resume()
    }
    
    
    //MARK:DownloadDelegateMethod
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print("urlSessionDidFinishEvents")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error == nil {
            print("didCompleteWithError")
        }else {
            task.resume()
        }
        
    }
    
    @available(iOS 7.0, *)
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("didFinishDownloadingTo")
        let fullpath = Path.caches.path+Path.separator+"sscaches/"+"\((downloadTask.currentRequest?.url?.absoluteString.md5)!)"
        print("\(fullpath)")
        do {
            try FileManager.default.moveItem(at: location, to: URL.init(fileURLWithPath: fullpath))
            
        } catch {
            
        }
        
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print("didResumeAtOffset")
    }
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        print("willPerformHTTPRedirection")
    }
}
