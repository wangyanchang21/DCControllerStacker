# DCControllerStacker

[![Platform](https://img.shields.io/badge/platform-iOS-lightgray.svg)]()
[![License](http://img.shields.io/badge/license-MIT-blue.svg)](http://mit-license.org)
[![Contact](https://img.shields.io/badge/contact-wangyanchang21-green.svg)](https://github.com/wangyanchang21)

DCControllerStacker是一个在 window中获取和管理层级关系的工具。它可以不依赖于当前的ViewController, 便于在代码的任何角落进行层级的管理。

![](https://github.com/wangyanchang21/DCControllerStacker/blob/master/Hierarchy.png)

## 主要功能

- 获取当前的正在展示的控制器（ViewController）
- 获取当前的导航控制器（NavigationController）
- 获取当前的标签控制器（TabBarController）
- 判断控制器是否存在于当前的导航控制器的栈中
- 切换选中的 Tab
- 导航控制器返回栈中指定类型的控制器
- 导航控制器返回下标为 Index的控制器
- 导航控制器向前返回指定层级数



## Usage

### Tab相关

1.获取当前的TabBarController. 如果没有, 则返回 nil.

```
UITabBarController *tab = [DCControllerStacker currentTabBarController];
```

2.选中第某个Tab. 

```
[DCControllerStacker transferToTabIndex:index];
```

### Navigation相关

1.获取当前的NavigationController. 如果没有, 则返回 nil.

```
UINavigationController *nav = [DCControllerStacker currentNavigationController]；
```

2.返回当前栈中类型为SomeClass的VC.
如果在其栈中有多个此类型的控制器, 栈顶的控制器优先级高于栈底的.

```
[DCControllerStacker popToViewControllerClass:[SomeClass class]];
```

3.返回当前Navigation栈中的下标为index的VC. 

```
[DCControllerStacker popToViewControllerPositive:index];
```

4.Navigation向前返回指定层级数.

```
[DCControllerStacker popToViewControllerReversed:count];
```

### ViewController相关

获取当前的正在展示的VC. 如果没有, 则返回 nil.

```
UIViewController *vc = [DCControllerStacker topViewController];
```


## Prerequisites

- Xcode 10
- iOS 8.0

## License

DCControllerStacker is licensed under the [MIT License](https://github.com/wangyanchang21/DCControllerStacker/blob/master/LICENSE).
