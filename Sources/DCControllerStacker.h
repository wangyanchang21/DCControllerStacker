//
//  DCControllerStacker.h
//
//  Created by DCSnail on 2017/10/18.
//  Copyright © 2017年 DCSnail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 v1.1

 DCControllerStacker is a tool that manage hierarchy in the window.
 It doesn't need to depend on ViewController, making it easy to manage hierarchy of Tab or Navigaiton anywhere in the code.
 Current class works in the window of AppDelegate only, does not work in other windows.

 DCControllerStacker是一个在 window中获取和管理层级关系的工具。
 它不需要依赖于ViewController, 便于在代码的任何角落进行Tab或者Navigaiton的层级管理。
 此类只用于 AppDelegate.window中的层级关系, 在其它 window中不奏效.
 */

@interface DCControllerStacker : NSObject


/**
 Return current TabBarController.
 If not found, return nil.
 
 获取当前的标签控制器. 如果没有, 则返回 nil.
 */
+ (UITabBarController *)currentTabBarController;

/**
 Return current NavigationController.
 If not found, return nil.

 获取当前的导航控制器. 如果没有, 则返回 nil.
 */
+ (UINavigationController *)currentNavigationController;

/**
 Return a viewcontroller that is currently being displayed in App.
 If not found, return nil.

 获取当前的正在展示的控制器. 如果没有, 则返回 nil.
 */
+ (UIViewController *)topViewController;

/**
 Return a boolean value indicating whether the viewcontroller is in the current navigation stack.
 
 判断控制器是否存在于当前的导航控制器的栈中.
 存在返回 YES; 不存在返回 NO.
 */
+ (BOOL)isInCurrentNavigationStack:(UIViewController *)viewController;

/**
 Current navigation controller pop to root viewcontroller, and select the tab according to index.
 
 当前导航控制器返回至根控制器, 并且根据 tabIndex 选中相应的 tab.
 */
+ (void)transferToTabIndex:(NSInteger)tabIndex;

/**
 Current navigation controller pop to the first controller which is the kind of aClass.
 If more than one controller in the navigation stack is kind of aClass,
 the controller in the higher position in stack will be pop.
 
 当前导航控制器返回至指定类型的控制器,
 如果在其栈中有多个此类型的控制器, 栈顶的控制器优先级高于栈底的.
 */
+ (void)popToViewControllerClass:(Class)aClass;

/**
 Current navigation controller pop to a controller in navigation stack according to the index.

 当前导航控制器返回至其栈中下标为 Index的控制器.
 */
+ (void)popToViewControllerPositive:(NSInteger)index;

/**
 Current navigation controller pop to a controller in navigation stack according to Reversed index.

 当前导航控制器返回至其栈中反向下标为 Index的控制器.
 当前导航控制器向前返回指定层级数, index表示层级数.
 */
+ (void)popToViewControllerReversed:(NSInteger)index;

@end
