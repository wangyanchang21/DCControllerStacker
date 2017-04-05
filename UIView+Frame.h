//
//  UIView+Frame.h
//  IOS-Categories
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
// shortcuts for frame properties
@property (nonatomic, assign) CGPoint view_origin;
@property (nonatomic, assign) CGSize view_size;

// shortcuts for positions
@property (nonatomic) CGFloat view_centerX;
@property (nonatomic) CGFloat view_centerY;


@property (nonatomic) CGFloat view_top;
@property (nonatomic) CGFloat view_bottom;
@property (nonatomic) CGFloat view_right;
@property (nonatomic) CGFloat view_left;

@property (nonatomic) CGFloat view_width;
@property (nonatomic) CGFloat view_height;
@property (nonatomic, assign) CGFloat view_x;
@property (nonatomic, assign) CGFloat view_y;


@end
