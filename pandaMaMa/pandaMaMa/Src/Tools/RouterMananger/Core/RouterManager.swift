//
//  RouterManager.swift
//  pandaMaMa
//
//  Created by tree on 2018/2/26.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation

@objc public protocol URLReceivable {
    
}

public typealias URLRoutesHandler = ([String: Any]) -> Void

typealias RoutePathNodeValueType = (URLReceivable.Type?, URLRoutesHandler?)

class RouterManager: NSObject {
    
    static let URLRouteURLKey = "URLRouterURL"
    
    fileprivate var routes = Trie<RoutePathNodeValueType>()
    static let `shared` = RouterManager()
    
    override init() {}
    
    @discardableResult
    public func register(_ url: URL, clazz: URLReceivable.Type) -> Bool {
        if let node = routes.searchNodeWithoutMatchPlaceholder(with: url), let (_, handler) = node.value {
            node.value = (clazz, handler)
            return true
        }
        return routes.insert((clazz, nil), with: url)
    }
    
    @discardableResult
    public func register(_ url: URL, handler: @escaping URLRoutesHandler) -> Bool {
        if let node = routes.searchNodeWithoutMatchPlaceholder(with: url), let (clazz, _) = node.value {
            node.value = (clazz, handler)
            return true
        }
        return routes.insert((nil, handler), with: url)
    }
    
    
    public func unregisterClazz(with url: URL) {
        guard let node = routes.searchNodeWithoutMatchPlaceholder(with: url) else { return }
        if let (_, handler) = node.value {
            if handler == nil {
                node.value = nil
                routes.remove(node)
            }else {
                node.value = (nil, handler)
            }
        }
    }
    
    public func unregisterHandler(with url: URL) {
        guard let node = routes.searchNodeWithoutMatchPlaceholder(with: url) else { return }
        if let (clazz, _) = node.value {
            if let clz = clazz {
                node.value = (clz, nil)
            }else {
                node.value = nil
                routes.remove(node)
            }
        }
    }
    public func searchClazz(with url: URL) -> ([String: Any], URLReceivable.Type?) {
        if let node = routes.search(with: url), let (clazz, _) = node.value {
            let param = routes.extractMatchedPattern(from: url, resultNode: node)
            return (extractParameters(from: url, defaultParame: param), clazz)
        }else { return (extractParameters(from: url), nil) }
    }
    
    public func searchHandler(with url: URL) -> ([String: Any], URLRoutesHandler?) {
        if let node = routes.search(with: url), let (_, handler) = node.value {
            let param = routes.extractMatchedPattern(from: url, resultNode: node)
            return (extractParameters(from: url, defaultParame: param), handler)
        }else {
            return (extractParameters(from: url), nil)
        }
    }
    
    public func extractParameters(from url: URL, defaultParame: [String: Any] = [:]) -> [String: Any] {
        var params = defaultParame
        params.updateValue(url, forKey: RouterManager.URLRouteURLKey)
        if let queryItems = url.queryItems {
            for queryItem in queryItems {
                if let value = queryItem.value {
                    params.updateValue(value, forKey: queryItem.name)
                }
            }
        }
        
        if let fragment = url.fragment {
            params.updateValue(fragment, forKey: "fragment")
        }
        return params
    }
}
