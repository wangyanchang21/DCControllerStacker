//
//  UIImage+DCLaunchImage.m
//
//  Created by DCSnial on 16/4/13.
//  Copyright © 2016年 DCSnial. All rights reserved.
//

#import "UIImage+DCLaunchImage.h"

#define kDCCurrentWindow [[UIApplication sharedApplication].windows firstObject]

@implementation UIImage (DCLaunchImage)

+ (UIImage *)DCLaunchImage {
    return [UIImage imageNamed:[self DCLaunchImageName]];
}

+ (NSString *)DCLaunchImageName {
    NSString *viewOrientation = @"Portrait";
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        viewOrientation = @"Landscape";
    }
    
    __block NSString *launchImageName = nil;
    CGSize viewSize = kDCCurrentWindow.bounds.size;
    NSArray *imagesArray = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    [imagesArray enumerateObjectsUsingBlock:^(NSDictionary *launchImageDic, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize imageSize = CGSizeFromString(launchImageDic[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:launchImageDic[@"UILaunchImageOrientation"]]) {
            launchImageName = launchImageDic[@"UILaunchImageName"];
            *stop = YES;
        }
    }];
    
    return launchImageName;
}


@end
