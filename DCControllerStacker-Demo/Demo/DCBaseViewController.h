//
//  DCBaseViewController.h
//  DCControllerStacker-Demo
//
//  Created by DCSnail on 2019/4/25.
//  Copyright © 2019 DCSnail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCCustomView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCBaseViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

NS_ASSUME_NONNULL_END
