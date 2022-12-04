//
//  DCCustomView.h
//  DCControllerStacker-Demo
//
//  Created by DCSnail on 2019/4/25.
//  Copyright © 2019 DCSnail. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r,g,b) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1.0]

NS_ASSUME_NONNULL_BEGIN

@interface DCCustomView : UIView

+ (instancetype)customView;

@end

NS_ASSUME_NONNULL_END
