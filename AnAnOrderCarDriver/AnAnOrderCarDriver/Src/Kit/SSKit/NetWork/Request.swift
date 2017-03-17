//
//  Request.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/9/24.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation

    ///封装SessionTaskDelegate的相关方法
open class TaskDelegate: NSObject {
    var data: Data? {return nil}
    var error: Error?
    open let queue: OperationQueue
    var task: URLSessionTask? {
        didSet { reSet() }
    }
    init(task: URLSessionTask?) {
        self.task = task
        self.queue = {
            let operationQueue = OperationQueue()
            operationQueue.maxConcurrentOperationCount = 1
            operationQueue.isSuspended = false
            operationQueue.qualityOfService = .utility
            return operationQueue
        }()
    }
    func reSet() {
        error = nil
    }
}




open class Reuqest {
    open var sessionDidSuccess:((Data,URLRequest , URLResponse)->Void)?
    private var taskDelegate: TaskDelegate
    private var taskDelegateLock: NSLock = NSLock.init()
    open internal(set) var delegate: TaskDelegate {
        get {
            taskDelegateLock.lock(); defer {taskDelegateLock.unlock()}
            return taskDelegate
        }
        set {
            taskDelegateLock.lock(); defer { taskDelegateLock.unlock()}
            taskDelegate = newValue
        }
    }
    open var task: URLSessionTask? { return delegate.task }
    open var request: URLRequest? { return task?.originalRequest}
    open var response: HTTPURLResponse?
    open var responseData:Data?
    open let session: URLSession
    
    
    init(session:URLSession, requestTask:URLSessionTask ,error:Error? = nil) {
        self.session = session
        taskDelegate = TaskDelegate.init(task:requestTask)
    }
    
    
}

open class DataRequest: Reuqest {
    
}




