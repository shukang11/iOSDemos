//
//  BLinSessionManager.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/9/23.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation

public typealias Parameters = [String: String]
public typealias HTTPHeaders = [String: String]
extension URLRequest {
    public init(url: URLConvertible, method: HTTPMethod, headers: HTTPHeaders? = nil) throws {
        let url = try url.asURL()
        self.init(url: url)
        httpMethod = method.rawValue
        if let headers = headers {
            for (headerField, headerValue) in headers {
                setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
    }
}

///                             会话的代理           数据的代理
class SessionManager: NSObject,URLSessionDelegate,URLSessionTaskDelegate,URLSessionDataDelegate {
    let configration: URLSessionConfiguration
    open var session: URLSession?
    open var delegate: TaskDelegate?
    var requests:[Int: Reuqest] = [:]
    let queue = DispatchQueue(label: "org.treee.session-manager"+UUID().uuidString)
    
    static let sharedInstance = SessionManager()
    
    var successBlocks:[URLSessionDataTask: (_ request:URLRequest, _ response:URLResponse)->()] = [:]
    
    /// 代理的方法
    var sessionDidBecomeInvalidWithError: ((URLSession,Error?) ->Void)?
    var sessionDidSuccess:((URLRequest , URLResponse)->Void)?
    
    public subscript(task:URLSessionTask)->Reuqest {
        get {
            return self.requests[task.taskIdentifier]!
        }
        set {
            self.requests[task.taskIdentifier] = newValue
        }
    }
    
    private override init() {
        self.configration = URLSessionConfiguration.default
        self.session = nil
    
        super.init()
    }
    
    public func GET(_ url:URLConvertible, method:HTTPMethod? = .get, parameters:Parameters? = nil,success:@escaping (_ data:Data, _ request:URLRequest, _ response:URLResponse)->()) ->Reuqest? {
        do {
            let urlRequest = try URLRequest(url: url, method: method!, headers: parameters)
            self.session = URLSession.init(configuration: self.configration, delegate: self, delegateQueue: OperationQueue.main)
            
//            OperationQueue.main.addOperation {
                let task = self.session?.dataTask(with: urlRequest)
                let request = Reuqest(session: self.session!, requestTask: task!)
                request.task?.resume()
                self[request.task!] = request
                request.sessionDidSuccess = success
            
            return request
//            }
        } catch {
            
        }
        return nil
    }
    
    
    
    
    //MARK: -
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Swift.Void) {
        
    }
    
    
    
    /// 接收到服务器的响应
    public func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        
        completionHandler(URLSession.AuthChallengeDisposition.performDefaultHandling, nil)
    }
    

    /// 需要新的数据?
    public func urlSession(_ session: URLSession, task: URLSessionTask, needNewBodyStream completionHandler: @escaping (InputStream?) -> Swift.Void) {
        
    }
    
    
    ///发送数据的方法
    public func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        
    }
    
   
    
    /// 请求成功或者失败 （如果失败那么error有值）
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("请求结果")
        if (error != nil) {
            ///failure
        }else {
            ///success
            let request = self[task]
            request.response = task.response as! HTTPURLResponse?
            request.sessionDidSuccess!(request.responseData!,task.originalRequest!, task.response!)
        }
        
    }
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("收到数据")
        let request = self[dataTask]
        request.responseData = data
//        print("\(String.init(data: data, encoding: String.Encoding.utf8))")
    }
   
}
