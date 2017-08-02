//
//  SSDcRouter.m
//  SSRoute
//
//  Created by tree on 2017/7/31.
//  Copyright © 2017年 treee. All rights reserved.
//

#import "SSDcRouter.h"

static SSDcRouter *sharedInstance = nil;

@implementation SSDcRouter
+ (SSDcRouter *)sharedInstance {
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
#pragma mark public
+ (void)openUrl:(NSString *)url {
    [self openUrl:url willRoute:nil];
}
+ (void)openUrl:(NSString *)url willRoute:(RouterObjectHandler)willRouteBlock {
    [self openUrl:url willRoute:willRouteBlock didRoute:nil];
}
+ (void)openUrl:(NSString *)url willRoute:(RouterObjectHandler)willRouteBlock didRoute:(RouterObjectHandler)didRouteBlock {
    [[self sharedInstance] openUrl:url willRoute:willRouteBlock didRoute:didRouteBlock];
}
- (SSRouterObject *)openUrl:(NSString *)url willRoute:(RouterObjectHandler)willRouteBlock didRoute:(RouterObjectHandler)didRouteBlock {
    SSRouterObject *obj = [[SSRouterObject alloc] initWithUrl:url];
    if (DEBUG) {
        NSAssert(obj, @"SSRouterObject cant init");
    }
    if ([obj isKindOfClass:[NSNull class]]) return obj;
    obj.didRouteBlock = didRouteBlock;
    obj.willRouteBlock = willRouteBlock;
    switch (obj.targetType) {
        case SSRouteTargetObject:
            [self routeObjectwithRouteObj:obj];
            break;
        case SSRouteTargetViewController:
            [self routeViewControllerWithRouteObject:obj];
            break;
        case SSRouteTargetNone:
            
            break;
    }
    return obj;
}
+ (BOOL)canOpenUrl:(NSString *)url {
    SSRouterObject *obj = [[SSRouterObject alloc] initWithUrl:url];
    if (obj.targetType == SSRouteTargetNone) return NO;
    return YES;
}
- (NSDictionary *)routeFileterDictronary {
    return [SSRouterObject routerFilter];
}
#pragma mark -
#pragma mark private
- (void)routeObjectwithRouteObj:(SSRouterObject *)object {
    if (!object.targetObj || !object) {
        NSLog(@"请检查配置文件");
        return;
    }
    if (object.willRouteBlock) {
        object.willRouteBlock(object);
    }
}
- (void)routeViewControllerWithRouteObject:(SSRouterObject *)object {
    if (!object.targetController || !object) {
        NSLog(@"请检查配置文件");
        return;
    }
    if (object.willRouteBlock) {
        object.willRouteBlock(object);
    }
    if ([object.targetController isKindOfClass:[UINavigationController class]] || [object.targetController isKindOfClass:[UITabBarController class]]) {//导航是控制器
        [self applicationDelegate].window.rootViewController = object.targetController;
    }else {
        UINavigationController *navigationController = [self currentNavigationViewController];
        if (navigationController) {
            [navigationController pushViewController:object.targetController animated:YES];
        }else {
            navigationController = [[UINavigationController alloc] initWithRootViewController:object.targetController];
            [self applicationDelegate].window.rootViewController = navigationController;
        }
    }
    if (object.didRouteBlock) {
        object.didRouteBlock(object);
    }
}
- (UIViewController *)currentViewController {
    UIViewController *rootViewController = self.applicationDelegate.window.rootViewController;
    return [self currentViewControllerFrom:rootViewController];
}
- (UINavigationController *)currentNavigationViewController {
    UIViewController *currentViewController = self.currentViewController;
    return currentViewController.navigationController;
}
- (id<UIApplicationDelegate>)applicationDelegate {
    return [UIApplication sharedApplication].delegate;
}
- (UIViewController *)currentViewControllerFrom:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    }else if (viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    }else {
        return viewController;
    }
}
@end

