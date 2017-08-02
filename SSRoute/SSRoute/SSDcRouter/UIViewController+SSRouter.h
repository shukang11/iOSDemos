//
//  UIViewController+SSRouter.h
//  SSRoute
//
//  Created by tree on 2017/7/31.
//  Copyright © 2017年 treee. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (SSRouter)

/** 跳转后的控制器拿到url */
@property (nonatomic, strong) NSURL *originUrl;
/** url路径 */
@property (nonatomic, strong) NSString *path;

/** 参数 */
@property (nonatomic, strong) NSDictionary *routeParams;

@end
NS_ASSUME_NONNULL_END
