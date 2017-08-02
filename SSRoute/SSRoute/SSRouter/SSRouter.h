//
//  SSRouter.h
//  SSRoute
//
//  Created by tree on 2017/7/31.
//  Copyright © 2017年 treee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const SSRouterPrarmeterURL;
extern NSString *const SSRouterParameterCompetion;
extern NSString *const SSRouterParameterUserInfo;

typedef void(^SSRouterHandler)(NSDictionary *routerParameters);

typedef id (^SSRouterObjectHandler)(NSDictionary *routerParameters);

@interface SSRouter : NSObject

+ (SSRouter *)sharedInstance;

/**
 注册URLPattern对应的handler， 在handler中可以初始化vc

 @param urlPattern 带上scheme e.g : mgj://beauty/:id
 @param handler 回调会传一个字典，包含注册信息中对应的变量
 */
+ (void)registerURLPattern:(NSString *)urlPattern toHandler:(SSRouterHandler)handler;

/**
 注册urlPattern 对应的ObjectHandler 需要返回一个对象给调用方

 @param urlPattern 带上scheme e.g : mgj://beauty/:id
 @param handler 回调会传一个字典，包含注册信息中对应的变量
 */
+ (void)registerURLPattern:(NSString *)urlPattern toObjectHandler:(SSRouterObjectHandler)handler;

/**
 取消注册某个urlPattern

 @param urlPattern urlPattern
 */
+ (void)cancelURLPattern:(NSString *)urlPattern;

/**
 打开一个url，会尝试寻找对应的回调

 @param urlPattern 带scheme的地址
 */
+ (void)openURL:(NSString *)urlPattern;

/**
 打开一个url，会尝试寻找对应的回调

 @param urlPattern 带 Scheme 的 URL
 @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (void)openURL:(NSString *)urlPattern completion:(void(^)(id result))completion;

/**
 打开一个url，会尝试寻找对应的回调
 */
+ (void)openURL:(NSString *)urlPattern withUserInfo:(NSDictionary *)userInfo completion:(void(^)(id result))completion;

/**
 查找谁对这个url感兴趣

 @param urlPattern 带 Scheme 的 URL
 @return 对象
 */
+ (id)objectForURL:(NSString *)urlPattern;

/**
 查找谁对这个url感兴趣
 */
+ (id)objectForURL:(NSString *)urlPattern withUserInfo:(NSDictionary *)userInfo;

/**
 能否打开一个URL
 @param urlPattern 带 Scheme 的 URL
 @return 可以打开返回YES，否则返回NO
 */
+ (BOOL)canOpenURL:(NSString *)urlPattern;

/**
 拼接urlPattern和parameters
 @param urlPattern 带 Scheme 的 URL
 @param parameters 一个数组，数量要跟 pattern 里的变量一致
 @return 返回生成的url字符串
 */
+ (NSString *)generateURLWithPattern:(NSString *)urlPattern parameters:(NSArray *)parameters;
@end


