//
//  UIView+Frame.m
//  IOS-Categories
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
#pragma mark - Shortcuts for the coords

- (CGFloat)view_top
{
    return self.frame.origin.y;
}

- (void)setView_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)view_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setView_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)view_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setView_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)view_left
{
    return self.frame.origin.x;
}

- (void)setView_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)view_width
{
    return self.frame.size.width;
}

- (void)setView_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)view_height
{
    return self.frame.size.height;
}

- (void)setView_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)view_origin {
    return self.frame.origin;
}

- (void)setView_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)view_size {
    return self.frame.size;
}

- (void)setView_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)view_centerX {
    return self.center.x;
}

- (void)setView_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)view_centerY {
    return self.center.y;
}

- (void)setView_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}
- (void)setView_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setView_y:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)view_x
{
    return self.frame.origin.x;
}

- (CGFloat)view_y
{
    return self.frame.origin.y;
}


@end
