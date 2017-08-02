//
//  SSRouter.m
//  SSRoute
//
//  Created by tree on 2017/7/31.
//  Copyright © 2017年 treee. All rights reserved.
//

#import "SSRouter.h"
#import <objc/runtime.h>

static NSString *const SS_ROUTER_WILDCARD_CHARACTER = @"~";
static NSString *specialCharacters = @"/?&.";
NSString *const SSRouterPrarmeterURL = @"SSRouterPrarmeterURL";
NSString *const SSRouterParameterCompetion = @"SSRouterParameterCompetion";
NSString *const SSRouterParameterUserInfo = @"SSRouterParameterUserInfo";
@interface SSRouter()
@property (strong, nonatomic) NSMutableDictionary *routes;
@end

static SSRouter *sharedInstance = nil;
@implementation SSRouter
+ (SSRouter *)sharedInstance {
    return [[self alloc] init];
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super init];
    });
    return sharedInstance;
}


#pragma mark -
#pragma mark Public

+ (void)registerURLPattern:(NSString *)urlPattern toHandler:(SSRouterHandler)handler {
    [[self sharedInstance] addURLPartter:urlPattern addHandler:handler];
}

+ (void)registerURLPattern:(NSString *)urlPattern toObjectHandler:(SSRouterObjectHandler)handler {
    [[self sharedInstance] addURLPattern:urlPattern andObjectHandler:handler];
}

+ (void)cancelURLPattern:(NSString *)urlPattern {
    [[self sharedInstance] removeURLPattern:urlPattern];
}

+ (void)openURL:(NSString *)urlPattern {
    [self openURL:urlPattern completion:nil];
}

+ (void)openURL:(NSString *)urlPattern completion:(void (^)(id))completion {
    [self openURL:urlPattern withUserInfo:nil completion:completion];
}
+ (void)openURL:(NSString *)urlPattern withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id))completion {
    urlPattern = [urlPattern stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameters = [[self sharedInstance] extractParametersFromURL:urlPattern];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            parameters[key] = [obj stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }];
    if (parameters) {
        SSRouterHandler handler = parameters[@"block"];
        if (completion) {
            parameters[SSRouterParameterCompetion] = completion;
        }
        if (userInfo) {
            parameters[SSRouterParameterUserInfo] = userInfo;
        }
        if (handler) {
            [parameters removeObjectForKey:@"block"];
            handler(parameters);
        }
    }
}

+ (BOOL)canOpenURL:(NSString *)urlPattern {
    return [[self sharedInstance] extractParametersFromURL:urlPattern]?YES
    :NO;
}

+ (NSString *)generateURLWithPattern:(NSString *)urlPattern parameters:(NSArray *)parameters {
    NSInteger startIndexOfColon = 0;
    NSMutableArray *placeholders = [NSMutableArray array];
    for (int i = 0; i < urlPattern.length; i ++) {
        NSString *character = [NSString stringWithFormat:@"%c", [urlPattern characterAtIndex:i]];
        if ([character isEqualToString:@":"]) {
            startIndexOfColon = i;
        }
        if ([specialCharacters rangeOfString:character].location != NSNotFound && i > (startIndexOfColon + 1) && (startIndexOfColon)) {
            NSRange range = NSMakeRange(startIndexOfColon, i - startIndexOfColon);
            NSString *placeholder = [urlPattern substringWithRange:range];
            if (![self checkIfContainsSpecialCharacter:placeholder]) {
                [placeholders addObject:placeholder];
                startIndexOfColon = 0;
            }
        }
        if (i == urlPattern.length - 1 && startIndexOfColon) {
            NSRange range = NSMakeRange(startIndexOfColon, i - startIndexOfColon + 1);
            NSString *placeholder = [urlPattern substringWithRange:range];
            if (![self checkIfContainsSpecialCharacter:placeholder]) {
                [placeholders addObject:placeholder];
            }
        }
    }
    __block NSString *parsedResult = urlPattern;
    [placeholders enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        idx = parameters.count > idx ? idx : parameters.count - 1;
        parsedResult = [parsedResult stringByReplacingOccurrencesOfString:obj withString:parameters[idx]];
    }];
    return parsedResult;
}

+ (id)objectForURL:(NSString *)urlPattern {
    return [self objectForURL:urlPattern withUserInfo:nil];
}
+ (id)objectForURL:(NSString *)urlPattern withUserInfo:(NSDictionary *)userInfo {
    SSRouter *router = [self sharedInstance];
    urlPattern = [urlPattern stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameters = [router extractParametersFromURL:urlPattern];
    SSRouterObjectHandler handler = parameters[@"block"];
    if (handler) {
        if (userInfo) {
            parameters[SSRouterParameterUserInfo] = userInfo;
        }
        [parameters removeObjectForKey:@"block"];
        return handler(parameters);
    }
    return nil;
}
#pragma mark -
#pragma mark private
- (NSMutableDictionary *)routes {
    if (_routes) return _routes;
    _routes = [[NSMutableDictionary alloc] init];
    return _routes;
}
- (void)addURLPartter:(NSString *)urlPattern addHandler:(SSRouterHandler)handler {
    NSMutableDictionary *subRoutes = [self addURLPattern:urlPattern];
    if (handler && subRoutes) {
        subRoutes[@"_"] = [handler copy];
    }
}

- (void)addURLPattern:(NSString *)URLPattern andObjectHandler:(SSRouterObjectHandler)handler {
    NSMutableDictionary *subRoutes = [self addURLPattern:URLPattern];
    if (handler && subRoutes) {
        subRoutes[@"_"] = [handler copy];
    }
}


- (NSMutableDictionary *)addURLPattern:(NSString *)URLPattern {
    NSArray *pathComonents = [self pathComponentsFromURL:URLPattern];
    NSMutableDictionary *subRouters = self.routes;
    for (NSString *pathComponent in pathComonents) {
        if (![subRouters objectForKey:pathComponent]) {
            subRouters[pathComponent] = [[NSMutableDictionary alloc] init];
        }
        subRouters = subRouters[pathComponent];
    }
    return subRouters;
}


#pragma mark -
#pragma mark Utils

/** 从url中提取参数 */
- (NSMutableDictionary *)extractParametersFromURL:(NSString *)url {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[SSRouterPrarmeterURL] = url;
    
    NSMutableDictionary *subRouters = [self.routes mutableCopy];
    NSArray *pathComponents = [self pathComponentsFromURL:url];
    
    BOOL found = NO;
    
    for (NSString* pathComponent in pathComponents) {
        
        // 对 key 进行排序，这样可以把 ~ 放到最后
        NSArray *subRoutesKeys =[subRouters.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return [obj1 compare:obj2];
        }];
        
        for (NSString* key in subRoutesKeys) {
            if ([key isEqualToString:pathComponent] || [key isEqualToString:SS_ROUTER_WILDCARD_CHARACTER]) {
                found = YES;
                subRouters = subRouters[key];
                break;
            } else if ([key hasPrefix:@":"]) {
                found = YES;
                subRouters = subRouters[key];
                NSString *newKey = [key substringFromIndex:1];
                NSString *newPathComponent = pathComponent;
                // 再做一下特殊处理，比如 :id.html -> :id
                if ([self.class checkIfContainsSpecialCharacter:key]) {
                    NSCharacterSet *specialCharacterSet = [NSCharacterSet characterSetWithCharactersInString:specialCharacters];
                    NSRange range = [key rangeOfCharacterFromSet:specialCharacterSet];
                    if (range.location != NSNotFound) {
                        // 把 pathComponent 后面的部分也去掉
                        newKey = [newKey substringToIndex:range.location - 1];
                        NSString *suffixToStrip = [key substringFromIndex:range.location];
                        newPathComponent = [newPathComponent stringByReplacingOccurrencesOfString:suffixToStrip withString:@""];
                    }
                }
                parameters[newKey] = newPathComponent;
                break;
            }
        }
        
        // 如果没有找到该 pathComponent 对应的 handler，则以上一层的 handler 作为 fallback
        if (!found && !subRouters[@"_"]) {
            return nil;
        }
    }    // Extract Params From Query.
    NSArray<NSURLQueryItem *> *queryItems = [[NSURLComponents alloc] initWithURL:[[NSURL alloc] initWithString:url] resolvingAgainstBaseURL:false].queryItems;
    
    for (NSURLQueryItem *item in queryItems) {
        parameters[item.name] = item.value;
    }
    
    if (subRouters[@"_"]) {
        parameters[@"block"] = [subRouters[@"_"] copy];
    }
    
    return parameters;
}
- (void)removeURLPattern:(NSString *)URLPattern {
    
}
- (NSArray*)pathComponentsFromURL:(NSString*)URL {
    NSMutableArray *pathComponents = [NSMutableArray array];
    if ([URL rangeOfString:@"://"].location != NSNotFound) {
        NSArray *pathSegments = [URL componentsSeparatedByString:@"://"];
        // 如果 URL 包含协议，那么把协议作为第一个元素放进去
        [pathComponents addObject:pathSegments[0]];
        
        // 如果只有协议，那么放一个占位符
        URL = pathSegments.lastObject;
        if (!URL.length) {
            [pathComponents addObject:SS_ROUTER_WILDCARD_CHARACTER];
        }
    }
    for (NSString *pathComponent in [[NSURL URLWithString:URL] pathComponents]) {
        if ([pathComponent isEqualToString:@"/"]) continue;
        if ([[pathComponent substringToIndex:1] isEqualToString:@"?"]) break;
        [pathComponents addObject:pathComponent];
    }
    return [pathComponents copy];
}
+ (BOOL)checkIfContainsSpecialCharacter:(NSString *)checkedString {
    NSCharacterSet *specialCharactersSet = [NSCharacterSet characterSetWithCharactersInString:specialCharacters];
    return [checkedString rangeOfCharacterFromSet:specialCharactersSet].location != NSNotFound;
}
@end

