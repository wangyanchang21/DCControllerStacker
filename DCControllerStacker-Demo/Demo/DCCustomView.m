//
//  DCCustomView.m
//  DCControllerStacker-Demo
//
//  Created by DCSnail on 2019/4/25.
//  Copyright © 2019 DCSnail. All rights reserved.
//

#import "DCCustomView.h"
#import "UIView+Toast.h"
#import "DCControllerStacker.h"

@implementation DCCustomView

+ (instancetype)customView {
    DCCustomView *view = [[DCCustomView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    [view makeUI];

    return view;
}

- (void)makeUI {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 300.0)];
    bgView.center = self.center;
    bgView.backgroundColor = RGB(245.0, 245.0, 245.0);
    bgView.layer.cornerRadius = 20.0;
    [self addSubview:bgView];

    NSArray *titleArray = @[@"当前栈顶VC", @"当前栈顶VC的Navigaiton", @"当前栈顶VC的TabBarController"];
    NSArray *selectorArray = @[@"getTopViewControllerInStack", @"getCurrentNavigationController", @"getCurrentTabBarController"];

    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0.0, 50.0 * (i + 1), bgView.bounds.size.width, 50.0);
        [button  setTitle:titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:NSSelectorFromString(selectorArray[i]) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
    }
}

- (void)getTopViewControllerInStack {
    UIViewController *vc = [DCControllerStacker topViewController];
    NSString *message = [NSString stringWithFormat:@"%@", vc];
    [[UIApplication sharedApplication].keyWindow makeToast:message];
    [self removeFromSuperview];
}

- (void)getCurrentNavigationController {
    UIViewController *vc = [DCControllerStacker currentNavigationController];
    NSString *message = vc ? [NSString stringWithFormat:@"%@", vc] : @"当前vc没有Navigation";
    [[UIApplication sharedApplication].keyWindow makeToast:message];
    [self removeFromSuperview];

}

- (void)getCurrentTabBarController {
    UIViewController *vc = [DCControllerStacker currentTabBarController];
    NSString *message = vc ? [NSString stringWithFormat:@"%@", vc] : @"当前vc没有Tab";
    [[UIApplication sharedApplication].keyWindow makeToast:message];
    [self removeFromSuperview];
}

@end
