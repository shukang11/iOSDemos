//
//  DetailPage.m
//  SSRoute
//
//  Created by tree on 2017/7/31.
//  Copyright © 2017年 treee. All rights reserved.
//

#import "DetailPage.h"
#import "ViewController.h"
@interface DetailPage ()

@end

@implementation DetailPage
+ (void)load {
    DetailPage *p = [DetailPage new];
    [ViewController registerWithTitle:@"测试" handler:^UIViewController *{
        return p;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
@end
