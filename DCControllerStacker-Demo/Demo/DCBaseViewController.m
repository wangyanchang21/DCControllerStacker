//
//  DCBaseViewController.m
//  DCControllerStacker-Demo
//
//  Created by DCSnail on 2019/4/25.
//  Copyright © 2019 DCSnail. All rights reserved.
//

#import "DCBaseViewController.h"
#import "DCPinkViewController.h"
#import "DCGreenViewController.h"
#import "DCPurpleViewController.h"
#import "DCControllerStacker.h"
#import "DCCustomView.h"

@interface DCBaseViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) DCCustomView *customView;

@end

static NSString *const kCellIdentifier = @"cell";

@implementation DCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 构造页面UI数据
    self.dataArray = [self constructData];

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = [NSString stringWithFormat:@"第%ld层", self.navigationController.viewControllers.count];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *actions = _dataArray[section][@"actions"];
    return actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    NSArray *actions = _dataArray[indexPath.section][@"actions"];
    cell.textLabel.text = actions[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSString *footer = _dataArray[section][@"footer"];
    if (footer.length > 0) {
        return 20.0;
    } else {
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [UILabel new];
    label.text = _dataArray[section][@"header"];
    return label;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UILabel *label = [UILabel new];
    label.backgroundColor = RGB(240, 240, 240);
    label.textAlignment =  NSTextAlignmentCenter;
    label.text = _dataArray[section][@"footer"];
    return label;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (0 == indexPath.section) {
        // 在CustomView中获取层级结构, 随时随地不依赖vc
        UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
        self.customView = [DCCustomView customView];
        [keywindow addSubview:_customView];
    } else if (1 == indexPath.section) {
        // Tab切换
        [DCControllerStacker transferToTabIndex:indexPath.row];
    } else if (2 == indexPath.section) {
        // 手动创建层级关系, Push三种页面类型(Pink, Green, Purple)
        if (0 == indexPath.row) {
            [self.navigationController pushViewController:[DCPinkViewController new] animated:true];
        } else if (1 == indexPath.row) {
            [self.navigationController pushViewController:[DCGreenViewController new] animated:true];
        } else if (2 == indexPath.row) {
            [self.navigationController pushViewController:[DCPurpleViewController new] animated:true];
        }
    } else if (3 == indexPath.section) {
        // 自动创建层级关系, 创建随机类型(Pink, Green, Purple)的页面, 且随机层级数小于20
        [self randomConfigViewControllerInNavigationStack];
    } else if (4 == indexPath.section) {
        // 返回至栈中指定类型的VC, 优先级栈顶高于栈底
        if (0 == indexPath.row) {
            [DCControllerStacker popToViewControllerClass:[DCPinkViewController class]];
        } else if (1 == indexPath.row) {
            [DCControllerStacker popToViewControllerClass:[DCGreenViewController class]];
        } else if (2 == indexPath.row) {
            [DCControllerStacker popToViewControllerClass:[DCPurpleViewController class]];
        }
    } else if (5 == indexPath.section) {
        // 跳转至栈中指定的第几个VC
        if (0 == indexPath.row) {
            [DCControllerStacker popToViewControllerPositive:0];
        } else if (1 == indexPath.row) {
            [DCControllerStacker popToViewControllerPositive:2];
        } else if (2 == indexPath.row) {
            [DCControllerStacker popToViewControllerPositive:4];
        } else if (3 == indexPath.row) {
            NSInteger random = arc4random() % self.navigationController.viewControllers.count;
            [DCControllerStacker popToViewControllerPositive:random];
        }
    } else {
        // 在栈中向前返回指定层级数
        if (0 == indexPath.row) {
            [DCControllerStacker popToViewControllerReversed:2];
        } else if (1 == indexPath.row) {
            [DCControllerStacker popToViewControllerReversed:4];
        } else if (2 == indexPath.row) {
            [DCControllerStacker popToViewControllerReversed:6];
        } else if (3 == indexPath.row) {
            NSInteger count = self.navigationController.viewControllers.count;
            if (count > 1) {
                NSInteger random = 1 + arc4random() % (count - 1);
                [DCControllerStacker popToViewControllerReversed:random];
            } else {
                NSLog(@"Can not pop, only one in navigation stack");
            }
        }
    }
}

- (NSArray *)constructData {
    return @[@{@"header" : @"1.获取层级结构",
               @"footer" : @"----- Tab -----",
               @"actions" : @[@"KeyWindow的View中获取层级结构"]},
             @{@"header" : @"2.切换Tab",
               @"footer" : @"----- 创建Navigation层级关系 -----",
               @"actions" : @[@"选中第1个Tab", @"选中第2个Tab"]},
             @{@"header" : @"3.手动创建VC层级关系",
               @"footer" : @"",
               @"actions" : @[@"Push粉色类型VC", @"Push绿色类型VC", @"Push紫色类型VC"]},
             @{@"header" : @"4.自动创建VC层级关系",
               @"footer" : @"----- Navigaiton Stack -----",
               @"actions" : @[@"Push随机的类型和层级"]},
             @{@"header" : @"5.Pop至栈中指定类型的VC",
               @"footer" : @"",
               @"actions" : @[@"粉色类型VC", @"绿色类型VC", @"紫色类型VC"]},
             @{@"header" : @"6.Pop至栈中第几个VC",
               @"footer" : @"",
               @"actions" : @[@"第1个VC", @"第3个VC", @"第5个VC", @"随机"]},
             @{@"header" : @"7.导航控制器向前返回指定层级数",
               @"footer" : @"",
               @"actions" : @[@"返回2层VC", @"返回4层VC", @"返回6层VC", @"随机"]}];
}

- (void)randomConfigViewControllerInNavigationStack {

    if (nil == self.navigationController) { return; }

    NSMutableArray *vcArray = [NSMutableArray arrayWithObject:self];

    NSInteger random = 1 + arc4random() % 19;
    for (int i = 0; i < random; i++) {
        NSInteger type = arc4random() % 3;
        NSString *vcClass = @"DCPinkViewController";
        switch (type) {
            case 2:
                vcClass = @"DCGreenViewController";
                break;
            case 1:
                vcClass = @"DCPurpleViewController";
                break;
            default:
                break;
        }
        [vcArray addObject: [NSClassFromString(vcClass) new]];
    }

    self.navigationController.viewControllers = vcArray;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

@end
