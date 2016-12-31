//
//  UILabel+ChangeDefaultFont.m
//  ChangeDefaultFontWithRuntime
//
//  Created by 宋志明 on 16/3/4.
//  Copyright © 2016年 宋志明. All rights reserved.
//

#import "UILabel+ChangeDefaultFont.h"
#import <objc/runtime.h>

static  NSString *fontName = @"Didot";

@implementation UILabel (ChangeDefaultFont)


/***每个NSObject的子类都会调用下面这个方法 在这里将init方法进行替换，使用我们的新字体*如果在程序中又特殊设置了字体 则特殊设置的字体不会受影响 但是不要在Label的init方法中设置字体*从init和initWithFrame和nib文件的加载方法 都支持更换默认字体*/
+(void)load{//只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:// Class class = object_getClass((id)self);
        //获取 系统的init方法
        SEL originalSelector = @selector(init);
        SEL originalSelector2 = @selector(initWithFrame:);
        SEL originalSelector3 = @selector(awakeFromNib);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method originalMethod2 = class_getInstanceMethod(class, originalSelector2);
        Method originalMethod3 = class_getInstanceMethod(class, originalSelector3);
        //创建新的init方法
        SEL swizzledSelector = @selector(YHBaseInit);
        SEL swizzledSelector2 = @selector(YHBaseInitWithFrame:);
        SEL swizzledSelector3 = @selector(YHBaseAwakeFromNib);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        Method swizzledMethod2 = class_getInstanceMethod(class, swizzledSelector2);
        Method swizzledMethod3 = class_getInstanceMethod(class, swizzledSelector3);
        
        BOOL didAddMethod =class_addMethod(class,originalSelector,method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
        BOOL didAddMethod2 =class_addMethod(class,originalSelector2,method_getImplementation(swizzledMethod2),method_getTypeEncoding(swizzledMethod2));
        BOOL didAddMethod3 =class_addMethod(class,originalSelector3,method_getImplementation(swizzledMethod3),method_getTypeEncoding(swizzledMethod3));
        if (didAddMethod) {
            class_replaceMethod(class,swizzledSelector,method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        if (didAddMethod2) {
            class_replaceMethod(class,swizzledSelector2,method_getImplementation(originalMethod2),method_getTypeEncoding(originalMethod2));
        }else{
            method_exchangeImplementations(originalMethod2, swizzledMethod2);
        }
        if (didAddMethod3) {
            class_replaceMethod(class,swizzledSelector3,method_getImplementation(originalMethod3),method_getTypeEncoding(originalMethod3));
        }else {
            method_exchangeImplementations(originalMethod3, swizzledMethod3);
        }
    });
}
/***在这些方法中将你的字体名字换进去*/
- (instancetype)YHBaseInit{
    id __self = [self YHBaseInit];
    UIFont * font = [UIFont fontWithName:fontName size:30];
    if (font) {
        self.font=font;
    }
    return __self;
}
-(instancetype)YHBaseInitWithFrame:(CGRect)rect{
    id __self = [self YHBaseInitWithFrame:rect];
    UIFont * font = [UIFont fontWithName:fontName size:30];
    if (font) {
        self.font=font;
    }
    return __self;
}
-(void)YHBaseAwakeFromNib{
    [self YHBaseAwakeFromNib];
    UIFont * font = [UIFont fontWithName:fontName size:30];
    if (font) {
        self.font=font;
    }
}

@end
