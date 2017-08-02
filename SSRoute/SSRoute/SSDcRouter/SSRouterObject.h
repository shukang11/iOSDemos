//
//  SSRouterObject.h
//  SSRoute
//
//  Created by tree on 2017/7/31.
//  Copyright © 2017年 treee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SSRouteConstant.h"

@class SSRouterObject;

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, SSRouteSource) {
    SSRouteSourceNone   = 0,//标识不是路由过来的
    SSRouteSourceScan   = 1,//扫码
    SSRouteSourceOpenUrl    = 2,//从别的应用跳过来
    SSRouteSourceRemoteNotification = 3,//远程推送
    SSRouteSourceSomeUrl    = 4,//自定义url
    SSRouteSourceAppFlow    = 5,//应用内的流程
};

typedef NS_ENUM(NSInteger, SSRouteTarget) {
    SSRouteTargetNone   = 0,//未知
    SSRouteTargetObject = 1,//对象
    SSRouteTargetViewController = 2,//界面
};

typedef void(^RouterObjectHandler)(SSRouterObject *obj);

/** 页面路由的对象模型 */
@interface SSRouterObject : NSObject

/** 所有的参数 */
@property (nonatomic, strong) NSDictionary *allParams;

/** url的字符串 */
@property (nonatomic, copy) NSString *originUrl;

/** 接口检查开始 */
@property (nonatomic, nullable, copy) RouterObjectHandler onCheckingBlock;
/** 即将跳转页面前回调 */
@property (nonatomic, nullable, copy) RouterObjectHandler willRouteBlock;
/** 跳转完成后的方法 */
@property (nonatomic, nullable, copy) RouterObjectHandler didRouteBlock;
/** 解析出来的控制器 */
@property (nonatomic, nullable, strong) UIViewController *targetController;

/** 目标可能是一个服务或者对象 */
@property (nonatomic, nullable, strong) id targetObj;
/** 目标类型 */
@property (nonatomic, assign) SSRouteTarget targetType;
/** 来源 */
@property (nonatomic, assign) SSRouteSource sourceType;

/** 错误消息 */
@property (nonatomic, copy) NSString *errorMsg;


/**
 初始化一个实例
 
 @param urlString 资源定位符
 @return 实例
 */
- (instancetype)initWithUrl:(nonnull NSString *)urlString;

/** 获得配置信息 */
+ (NSDictionary *)routerFilter;
@end
NS_ASSUME_NONNULL_END
