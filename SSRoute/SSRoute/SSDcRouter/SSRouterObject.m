//
//  SSRouterObject.m
//  SSRoute
//
//  Created by tree on 2017/7/31.
//  Copyright © 2017年 treee. All rights reserved.
//

#import "SSRouterObject.h"

@implementation SSRouterObject

- (instancetype)initWithUrl:(NSString *)urlString {
    self = [super init];
    NSURL *url = [NSURL URLWithString:urlString];
    self.originUrl = urlString;
    NSString *home = @"";
    Class cls = nil;
    if (url.path == nil) {
        home = [NSString stringWithFormat:@"%@://%@",url.scheme, url.host];
    }else {
        home = [NSString stringWithFormat:@"%@://%@%@",url.scheme, url.host, url.path];
    }
    if (url.query) {
        self.allParams = [self encodeDictionaryWithString:url.query];
    }
    NSDictionary *configDic = [[self class] routerFilter];
    if ([configDic.allKeys containsObject:url.scheme]) {
        //配置文件中包含传入的协议头
        id config = [configDic objectForKey:url.scheme];
        if ([config isKindOfClass:[NSString class]]) {
            //协议头是http或者是https
            self.targetController = [self encodeViewControllerWithString:config];
        }
        else if ([config isKindOfClass:[NSArray class]]) {
            // 自定义的url情况
            NSString *tempString = [NSString stringWithFormat:@"%@%@",url.host, url.path];
            NSArray *array = (NSArray *)config;
            for (NSDictionary *dict in array) {//遍历自定义规则
                if ([tempString isEqualToString:[dict objectForKey:k_Protocol_Url_key]]) {
                    if ([[dict objectForKey:k_Protocol_Url_Object] hasPrefix:@"#"]) {
                        self.targetController = [self encodeViewControllerWithString:[dict objectForKey:k_Protocol_Url_Object]];
                        if (self.targetController) self.targetType = SSRouteTargetViewController;
                    }else {
                        self.targetObj = [self encodeObjectWithString:[dict objectForKey:k_Protocol_Url_Object]];
                        if (self.targetObj) self.targetType = SSRouteTargetObject;
                    }
                }
            }
        }
        if (self.targetType == SSRouteTargetNone) {
            self.errorMsg = @"该地址无效";
        }
    }
    return self;
}

/** 获得配置信息 */
+ (NSDictionary *)routerFilter {
    static NSDictionary *tempDic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:k_RouterFilter_FileName ofType:@"plist"];
        tempDic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSAssert([tempDic isKindOfClass:[NSDictionary class]], @"读取配置文件错误%@", path);
    });
    return tempDic;
}

/** 将字符串中解析出界面的类 */
- (UIViewController *)encodeViewControllerWithString:(NSString *)clsString {
    Class cls = nil;
    UIViewController *VC = nil;
    if (!clsString || clsString.length < 1) return VC;
    if ([clsString hasPrefix:k_ViewController_symbol]) {
        clsString = [clsString substringFromIndex:1];
    }
    cls = NSClassFromString(clsString);
    if (cls != nil) {
        VC = [[cls alloc] init];
    }
    return VC;
}

/** 将字符串中的对象模型解析出来 */
- (id)encodeObjectWithString:(NSString *)clsString {
    Class cls = nil;
    id Obj = nil;
    if (!clsString || clsString.length < 1) return Obj;
    cls = NSClassFromString(clsString);
    if (cls != nil) {
        Obj = [[cls alloc] init];
    }
    return Obj;
}
/** 将资源定位字符中的参数解析出来 */
- (NSDictionary *)encodeDictionaryWithString:(NSString *)queryString {
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    if (queryString.length) {
        for (NSString *tempStr in [queryString componentsSeparatedByString:@"&"]) {
            NSArray *tem = [tempStr componentsSeparatedByString:@"="];
            tempDic[[tem firstObject]] = [tem lastObject];
        }
    }
    return [tempDic copy];
}

@end
