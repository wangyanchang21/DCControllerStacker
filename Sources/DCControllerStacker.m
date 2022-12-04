//
//  DCControllerStacker.m
//
//  Created by DCSnail on 2017/10/18.
//  Copyright © 2017年 DCSnail Mobile. All rights reserved.
//

#import "DCControllerStacker.h"

@implementation DCControllerStacker

#ifdef DEBUG
    #define DCLog(...) NSLog(__VA_ARGS__)
#else
    #define DCLog(...)
#endif

#pragma mark - TabBarController

+ (UITabBarController *)currentTabBarController {
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        return (UITabBarController *)rootVC;
    }
    return nil;
}

#pragma mark - NavigationController

+ (UINavigationController *)currentNavigationController {
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 注: 首页Tab下,切换Tab,切换后VC的ViewDidLoad方法中使用,获取selectedViewController可能为切换前的VC.
        UIViewController *tabSelectVC = [(UITabBarController *)rootVC selectedViewController];
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)tabSelectVC;
        }
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)rootVC;
    }
    return nil;
}

+ (BOOL)isInCurrentNavigationStack:(UIViewController *)viewController {
    __block BOOL isContain = NO;
    [[[self currentNavigationController] viewControllers] enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([viewController isEqual:obj]) {
            isContain = YES;
            *stop = YES;
        }
    }];
    return isContain;
}

#pragma mark - ViewController

+ (UIViewController *)topViewController {
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UIViewController *tabSelectVC = [(UITabBarController *)rootVC selectedViewController];
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            return [(UINavigationController *)tabSelectVC topViewController];
        } else {
            return tabSelectVC;
        }
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController *)rootVC topViewController];
    } else {
        return rootVC;
    }
}

#pragma mark - HierarchyManager

+ (void)transferToTabIndex:(NSInteger)tabIndex {
    UITabBarController *tabController = [DCControllerStacker currentTabBarController];
    
    if (tabController) {
        UINavigationController *nav = [DCControllerStacker currentNavigationController];
        if (nav) {
            [nav popToRootViewControllerAnimated:NO];
        } else {
            DCLog(@"App don't has navigation controller");
        }
        
        NSInteger tabCount = tabController.viewControllers.count;
        if (tabIndex < tabCount) {
            [tabController setSelectedIndex:tabIndex];
        } else {
            DCLog(@"The tabIndex is beyond tab count");
        }
    } else {
        DCLog(@"App don't has tab controller");
    }
}

+ (void)popToViewControllerClass:(Class)aClass {
    UINavigationController *nav = [self currentNavigationController];
    if (nav == nil) return;

    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, nav.viewControllers.count - 1)];
    [nav.viewControllers enumerateObjectsAtIndexes:indexSet options:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([vc isKindOfClass:aClass]) {
            [nav popToViewController:vc animated:YES];
            *stop = YES;
        }
    }];
}

+ (void)popToViewControllerPositive:(NSInteger)index {
    UINavigationController *nav = [self currentNavigationController];
    if (nav == nil) return;

    NSInteger maxIndex = nav.viewControllers.count - 1;
    if (index >= 0 && index < maxIndex) {
        UIViewController *vc = [nav.viewControllers objectAtIndex:index];
        [nav popToViewController:vc animated:true];
    } else {
        DCLog(@"The positive index is beyond count");
    }
}

+ (void)popToViewControllerReversed:(NSInteger)index {
    UINavigationController *nav = [self currentNavigationController];
    if (nav == nil) return;

    NSInteger maxIndex = nav.viewControllers.count - 1;
    NSInteger positiveIndex = maxIndex - index;
    if (positiveIndex >= 0 && positiveIndex < maxIndex) {
        UIViewController *vc = [nav.viewControllers objectAtIndex:positiveIndex];
        [nav popToViewController:vc animated:true];
    } else {
        DCLog(@"The Reversed index is beyond count");
    }
}

@end
