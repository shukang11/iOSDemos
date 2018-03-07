//
//  WebTest.swift
//  pandaMaMa
//
//  Created by tree on 2018/1/25.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import Alamofire
protocol TestWebServiceProtocol {
    func send(url: String, method: HTTPMethod, params: [String: Any], header:[String: String]?) -> Void
}

class TestHttp: NSObject, TestWebServiceProtocol, HookModuleProtocol {
    func send(url: String="", method: HTTPMethod = .get, params: [String: Any]=[:], header: [String: String]?) -> Void {
        let urlString = kPort_script_URL + url
        Alamofire.request(urlString, method: method, parameters: params, encoding: JSONEncoding(), headers: header).responseJSON { (response) in
            print(response)
        }
    }
    
    func index_banner() -> (String, HTTPMethod, [String: Any], [String: String]) {
        // 首页banner
        let url: String = "/index/banner"
        let method: HTTPMethod = .get
        let params: [String: Any] = [:]
        let headers: [String: String] = [:]
        return (url, method, params, headers)
    }
    
    func index_modules() -> (String, HTTPMethod, [String: Any], [String: String]) {
        let url: String = "/index/modules"
        let method: HTTPMethod = .get
        let params: [String: Any] = [:]
        let headers: [String: String] = [:]
        return (url, method, params, headers)
    }
    
    func item_detail(item_id: String) -> (String, HTTPMethod, [String: Any], [String: String]) {
        let url: String = "/item/\(item_id)"
        let method: HTTPMethod = .get
        let params: [String: Any] = [:]
        let headers: [String: String] = [:]
        return (url, method, params, headers)
    }
    
    func item_detail(item_id: String, cart_sku_id: String, cart_sku_num: String) -> (String, HTTPMethod, [String: Any], [String: String]) {
        let url: String = "/cart/add"
        let method: HTTPMethod = .post
        let params: [String: Any] = ["cart_item_id":item_id,
                                     "cart_sku_id": cart_sku_id,
                                     "cart_sku_num":cart_sku_num]
        let headers: [String: String] = [:]
        return (url, method, params, headers)
    }
    
    func payment(order_sn: String) -> (String, HTTPMethod, [String: Any], [String: String]) {
        let url: String = "/payment"
        let method: HTTPMethod = .get
        let params: [String: Any] = ["pay_platform":"1",
                                     "pay_machine_code": "mac x86",
                                     "pay_system_version": "10.12.0",
                                     "pay_app_version": "0.0.1.build",
                                     "pay_type": "1",
                                     "order_sn": order_sn]
        let headers: [String: String] = [:]
        return (url, method, params, headers)
    }
    
    func test() -> Void {
//        var (url, method, params, headers) = index_banner()
//        var (url, method, params, headers) = index_modules()
        var (url, method, params, headers) = item_detail(item_id: "11")
//        var (url, method, params, headers) = index_banner()
        params.updateValue("e6e25d4e4495e694dee2b16610b687e2", forKey: "token")
    
        
        // /cart/synchro
//        url = "/cart/synchro"
//        method = .get
        
        // /cart/update
//        url = "/cart/update"
//        url = "/order/preview"
        
//        url = "/order/detail/2018012713105173361122"
//        method = .get
        
//        url = "/order/add"
//        method = .post
//        var value:[Dictionary<String, Any>] = []
//        value.append({
//            let o: [String: Any] = ["item_id":1, "num":33, "sn":"9787121297335"]
//            return o
//            }())
//        value.append({
//            let o: [String: Any] = ["item_id":37, "num":100, "sn":"8423739277756"]
//            return o
//            }())
//        params.updateValue(value, forKey: "goods_info")
//        params.updateValue("1", forKey: "rec_address_id")

        send(url: url, method: method, params: params, header: headers)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
//        self.test()
        return true
    }
}

