//
//  SSDcRouter.h
//  SSRoute
//
//  Created by tree on 2017/7/31.
//  Copyright © 2017年 treee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSRouterObject.h"
#import "SSRouteConstant.h"
NS_ASSUME_NONNULL_BEGIN
/** 页面路由控制 */
@interface SSDcRouter : NSObject
+ (SSDcRouter *)sharedInstance;
/**
 打开一个url

 @param url url
 */
+ (void)openUrl:(nonnull NSString *)url;

/**
 打开一个url， 即将动作前有回调

 @param url url
 @param willRouteBlock 动作前的回调
 */
+ (void)openUrl:(nonnull NSString *)url willRoute:(nullable RouterObjectHandler)willRouteBlock;

/**
 打开一个url

 @param url url
 @param willRouteBlock 动作前的回调
 @param didRouteBlock 动作完成的回调
 */
+ (void)openUrl:(nonnull NSString *)url willRoute:(nullable RouterObjectHandler)willRouteBlock didRoute:(nullable RouterObjectHandler)didRouteBlock;

/**
 可以获得一个路有对象的实例方法

 @param url url
 @param willRouteBlock 动作前回调
 @param didRouteBlock 动作完成后回调
 @return 实例方法
 */
- (SSRouterObject *)openUrl:(NSString *)url willRoute:(RouterObjectHandler)willRouteBlock didRoute:(RouterObjectHandler)didRouteBlock;

/**
 检测能否处理url

 @param url url
 @return 可以处理返回YES,否则返回NO
 */
+ (BOOL)canOpenUrl:(nonnull NSString *)url;

/**
 获得路由配置内容

 @return 字典形式
 */
- (NSDictionary *)routeFileterDictronary;
@end
NS_ASSUME_NONNULL_END
