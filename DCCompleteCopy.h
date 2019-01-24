//
//  DCCompleteCopy.h
//  CopySummary
//
//  Created by DCSnial on 16/3/30.
//  Copyright © 2016年 DCSnial. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSArray

@interface NSArray (DCCompleteCopy)

- (NSArray *)deepCopy;
- (NSMutableArray *)mutableDeepCopy;

@end

#pragma mark - NSDictionary

@interface NSDictionary (DCCompleteCopy)

- (NSDictionary *)deepCopy;
- (NSMutableDictionary *)mutableDeepCopy;

@end
