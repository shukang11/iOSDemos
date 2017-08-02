//
//  ViewController.h
//  SSRoute
//
//  Created by tree on 2017/7/31.
//  Copyright © 2017年 treee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSRouter.h"
typedef UIViewController *(^ViewControllerHandler)();
@interface ViewController : UIViewController
+ (void)registerWithTitle:(NSString *)title handler:(ViewControllerHandler)handler;
@end

