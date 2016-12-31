//
//  UIImage+DCLaunchImage.h
//  LeZhanCloud
//
//  Created by MyMac on 16/4/13.
//  Copyright © 2016年 YYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DCLaunchImage)

+ (NSString *)getLaunchImageName;

+ (UIImage *)getLaunchImage;


//对 image 进行缩放
- (UIImage *)getImageWithOriginalImage:(UIImage *)image scaledToSize:(CGSize)newSize;
//对 image 进行剪切
- (UIImage *)getImageByOriginalImage:(UIImage *)image cutFromRect:(CGRect)cutRect;

@end
