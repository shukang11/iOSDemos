//
//  ListPage.m
//  SSRoute
//
//  Created by tree on 2017/8/2.
//  Copyright © 2017年 treee. All rights reserved.
//
#import "ListPage.h"

@interface ListPage ()

@end

@implementation ListPage
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createMainUI];
    self.title = @"商品详情";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark HTTP

#pragma mark -
#pragma mark Delegate&DataSource


#pragma mark -
#pragma mark Custom Method
- (void)createMainUI {
    
}


#pragma mark -
#pragma mark getter&&setter

#pragma mark -
#pragma mark helper
@end
