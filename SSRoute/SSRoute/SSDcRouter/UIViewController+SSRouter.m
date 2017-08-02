//
//  UIViewController+SSRouter.m
//  SSRoute
//
//  Created by tree on 2017/7/31.
//  Copyright © 2017年 treee. All rights reserved.
//

#import "UIViewController+SSRouter.h"
#import <objc/runtime.h>

static char URLoriginUrl;
static char URLpath;
static char URLparams;

@implementation UIViewController (SSRouter)
- (void)setOriginUrl:(NSURL *)originUrl {
    // 为分类设置属性值
    objc_setAssociatedObject(self, &URLoriginUrl, originUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURL *)originUrl {
    // 获取分类的属性值
    return objc_getAssociatedObject(self, &URLoriginUrl);
}
- (NSString *)path {
    return objc_getAssociatedObject(self, &URLpath);
}

- (void)setPath:(NSURL *)path{
    objc_setAssociatedObject(self, &URLpath, path, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)routeParams {
    return objc_getAssociatedObject(self, &URLparams);
}

- (void)setRouteParams:(NSDictionary *)routeParams {
    objc_setAssociatedObject(self, &URLparams, routeParams, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
