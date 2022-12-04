//
//  DCGreenViewController.m
//  DCControllerStacker-Demo
//
//  Created by DCSnail on 2019/4/25.
//  Copyright © 2019 DCSnail. All rights reserved.
//

#import "DCGreenViewController.h"

@interface DCGreenViewController ()

@end

@implementation DCGreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = RGB(230.0, 255.0, 230.0);

    if (nil == self.navigationController) {
        self.dataArray = @[@{@"header" : @"1.获取层级结构",
                             @"footer" : @"----- Tab -----",
                             @"actions" : @[@"KeyWindow的View中获取层级结构"]},
                           @{@"header" : @"2.切换Tab",
                             @"footer" : @"",
                             @"actions" : @[@"选中第1个Tab", @"选中第2个Tab"]}];
    }
}

@end
