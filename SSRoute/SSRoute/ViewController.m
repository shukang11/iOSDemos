//
//  ViewController.m
//  SSRoute
//
//  Created by tree on 2017/7/31.
//  Copyright © 2017年 treee. All rights reserved.
//

#import "ViewController.h"
#import "SSDcRouter.h"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITableView *tableView;

@end
static NSMutableDictionary *titleWithHandlers;
static NSMutableArray *titles;
@implementation ViewController

+ (void)registerWithTitle:(NSString *)title handler:(UIViewController *(^)())handler
{
    if (!titleWithHandlers) {
        titleWithHandlers = [[NSMutableDictionary alloc] init];
        titles = [NSMutableArray array];
    }
    [titles addObject:title];
    titleWithHandlers[title] = handler;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MGJRouterDemo";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    /**
    NSString *parameterStr = @"https://zsapp10001/china/abc.com?a=1&b=2";
    [SSRouter registerURLPattern:parameterStr toHandler:^(NSDictionary *routerParameters) {
        self.title = @"changed";
        [self.navigationController pushViewController:[UIViewController new] animated:YES];
    }];
    [SSRouter openURL:parameterStr];
    NSString *str = [SSRouter generateURLWithPattern:@"https://www.baidu.com/:haha&:sex" parameters:@[@"12",@"男"]];
    NSLog(@"%@",str);
     */
    
    [SSDcRouter openUrl:@"panda://page.panda/newView"];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self routeMethod];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titleWithHandlers.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController = ((ViewControllerHandler)titleWithHandlers[titles[indexPath.row]])();
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)routeMethod {
    [SSDcRouter openUrl:@"panda://page.panda/page1?productid=11&detail=aass" willRoute:^(SSRouterObject * _Nonnull obj) {
        if (obj.targetType == SSRouteTargetViewController) {
            NSLog(@"即将进入");
        }
    } didRoute:^(SSRouterObject * _Nonnull obj) {
        if (obj.targetType == SSRouteTargetViewController) {
            obj.targetController.title = @"我是第二层";
            NSLog(@"已经进入");
        }
    }];
    
    
}
@end
