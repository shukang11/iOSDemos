//
//  BaseRequest.swift
//  pandaMaMa
//
//  Created by tree on 2018/1/15.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import Alamofire

typealias RequestComletionBlock = (_ request:BaseRequest)-> Void

enum SSRequestSerializerType {
    case HTTP
    case JSON
}
enum SSResponseSerializerType {
    case HTTP
    case JSON
}

protocol BaseRequestDelegate {
    
}

protocol BaseRequestProtocol {
}

class BaseRequest: NSObject, BaseRequestProtocol {
    //MARK:-
    //MARK:Request && Response Information
    private(set) var requestTask: URLSessionTask?
    
    private(set) var currentReqest: URLRequest?
    
    private (set) var originalRequest: URLRequest?
    
    private(set) var response: HTTPURLResponse?
    
    private(set) var responseStatusCode: Int?
    
    private(set) var responseHeaders: [String: String]?
    
    private(set) var responseData: Data?
    
    private(set) var responseString: String?
    
    private(set) var responseObj: Any?
    
    private(set) var responseJSONObject: Any?
    
    private var cancelled: Bool = false
    
    private var executing: Bool = false
    
    //MARK:-
    //MARK:requestConfiguration
    public var tag: Int = 0
    
    public var userInfo: [String: Any]?

    public var delegate: BaseRequestDelegate?
    
    public var successBlock: RequestComletionBlock?
    
    public var failureBlock: RequestComletionBlock?
    
    public var isCancelled: Bool {
        get {
            if let request = self.requestTask {
                return request.state == .canceling
            }else { return false }
        }
    }
    public var isExecuting: Bool {
        get {
            if let request = self.requestTask {
                return request.state == .running
            }else { return false }
        }
    }
    
    override init() {}
    
    //MARK:-
    //MARK:Action
    public func start() -> Void {
        RequestCtrl.shared.push(request: self)
    }
    
    public func stop() -> Void {
        RequestCtrl.shared.cancel(request: self)
    }
    
    public func start(_ completion: @escaping RequestComletionBlock, failure: @escaping RequestComletionBlock) -> Void {
        self.successBlock = completion
        self.failureBlock = failure
        self.start()
    }
    
    //MARK:-
    //MARK:Overrideclass
    public func clearBlock() -> Void {
        self.successBlock = nil
        self.failureBlock = nil
    }
    
    public func baseUrl() -> String { return "" }
    
    public func requestUrl() -> String { return "" }
    
    public func requestTimeoutInterval() -> TimeInterval { return 60.0 }
    
    public func requestArgument() -> Any? { return nil }
    
    public func buildCustomRequest() -> URLRequest? { return nil }
    
    public func requestMethod() -> HTTPMethod { return .get }
    
    public func requestSerializerType() -> SSRequestSerializerType { return .JSON }
    
    public func responseSerializerType() -> SSResponseSerializerType { return .JSON }
    
    public func requestHeaderField() -> [String: String]? { return nil }
    
    public func jsonValidator() -> Any? { return nil }
    public func statusCodeValidator() -> Bool {
        if let code: Int = self.responseStatusCode {
            return code >= 200 && code <= 299
        }
        return false
    }
}






