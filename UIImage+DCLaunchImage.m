//
//  UIImage+DCLaunchImage.m
//  LeZhanCloud
//
//  Created by MyMac on 16/4/13.
//  Copyright © 2016年 YYQ. All rights reserved.
//

#import "UIImage+DCLaunchImage.h"

//current window
#define tyCurrentWindow [[UIApplication sharedApplication].windows firstObject]

@implementation UIImage (DCLaunchImage)
// 引用自stackflow
+ (NSString *)getLaunchImageName
{
    NSString *viewOrientation = @"Portrait";
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        viewOrientation = @"Landscape";
    }
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    CGSize viewSize = tyCurrentWindow.bounds.size;
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}

+ (UIImage *)getLaunchImage
{
    return [UIImage imageNamed:[self getLaunchImageName]];
}





- (UIImage *)getImageWithOriginalImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake( 0, 0, newSize.width, newSize.height)];
    // Get the new image from the context
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

- (UIImage *)getImageByOriginalImage:(UIImage *)image cutFromRect:(CGRect)cutRect
{
    //根据范围截图
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, cutRect);
    
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    
    return smallImage;
}


@end
