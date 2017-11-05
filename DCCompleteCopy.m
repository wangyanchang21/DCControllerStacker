//
//  DCCompleteCopy.m
//  CopySummary
//
//  Created by MyMac on 16/3/30.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import "DCCompleteCopy.h"


#pragma mark - NSArray

@implementation NSArray (DCCompleteCopy)

- (NSArray *)deepCopy
{
    NSUInteger count = [self count];
    id cArray[count];
    
    for (NSUInteger i = 0; i < count; i++) {
        id obj = self[i];
        
        if ([obj respondsToSelector:@selector(deepCopy)]) {
            cArray[i] = [obj deepCopy];
        } else if ([obj respondsToSelector:@selector(copyWithZone:)]) {
            cArray[i] = [obj copy];
        } else {
            //DLog(@"********Error:NSArray DeepCopy Failed!!! ********");
            return nil;
        }
    }
    
    return [NSArray arrayWithObjects:cArray count:count];
}

- (NSMutableArray *)mutableDeepCopy
{
    NSUInteger count = [self count];
    id cArray[count];
    
    for (NSUInteger i = 0; i < count; i++) {
        id obj = self[i];
        
        if ([obj respondsToSelector:@selector(mutableDeepCopy)]) {
            cArray[i] = [obj mutableDeepCopy];
        } else if ([obj respondsToSelector:@selector(mutableCopyWithZone:)]) {
            cArray[i] = [obj mutableCopy];
        } else if ([obj respondsToSelector:@selector(deepCopy)]) {
            cArray[i] = [obj deepCopy];
        } else if ([obj respondsToSelector:@selector(copyWithZone:)]) {
            cArray[i] = [obj copy];
        } else {
            //DLog(@"********Error:NSArray MutableDeepCopy Failed!!! ********");
            return nil;
        }
    }
    
    return [NSMutableArray arrayWithObjects:cArray count:count];
}

@end


#pragma mark - NSDictionary

@implementation NSDictionary (DCCompleteCopy)

- (NSDictionary *)deepCopy
{
    NSUInteger count = [self count];
    id cObjects[count];
    id cKeys[count];
    
    NSEnumerator *e = [self keyEnumerator];
    NSUInteger i = 0;
    id thisKey;
    
    while ((thisKey = [e nextObject]) != nil) {
        id obj = self[thisKey];
        
        if ([obj respondsToSelector:@selector(deepCopy)]) {
            cObjects[i] = [obj deepCopy];
        } else if([obj respondsToSelector:@selector(copyWithZone:)]) {
            cObjects[i] = [obj copy];
        } else {
            //DLog(@"********Error:NSDictionary DeepCopy Failed!!! ********")
            return nil;
        }
        
        if ([thisKey respondsToSelector:@selector(deepCopy)]) {
            cKeys[i] = [thisKey deepCopy];
        } else if ([thisKey respondsToSelector:@selector(copyWithZone:)]) {
            cKeys[i] = [thisKey copy];
        } else {
            //DLog(@"********Error:NSDictionary Key DeepCopy Failed!!! ********")
            return nil;
        }
        
        ++i;
    }
    
    return [NSDictionary dictionaryWithObjects:cObjects forKeys:cKeys count:count];
}

- (NSMutableDictionary *)mutableDeepCopy
{
    NSUInteger count = [self count];
    id cObjects[count];
    id cKeys[count];
    
    NSEnumerator *e = [self keyEnumerator];
    NSUInteger i = 0;
    id thisKey;
    
    while ((thisKey = [e nextObject]) != nil) {
        id obj = self[thisKey];
        
        if ([obj respondsToSelector:@selector(mutableDeepCopy)]) {
            cObjects[i] = [obj mutableDeepCopy];
        } else if ([obj respondsToSelector:@selector(mutableCopyWithZone:)]) {
            cObjects[i] = [obj mutableCopy];
        } else if ([obj respondsToSelector:@selector(deepCopy)]) {
            cObjects[i] = [obj deepCopy];
        } else if ([thisKey respondsToSelector:@selector(copyWithZone:)]) {
            cObjects[i] = [thisKey copy];
        } else {
            //DLog(@"********Error:NSDictionary Key DeepCopy Failed!!! ********")
            return nil;
        }
        
        if ([thisKey respondsToSelector:@selector(deepCopy)]) {
            cKeys[i] = [thisKey deepCopy];
        } else if ([thisKey respondsToSelector:@selector(copyWithZone:)]) {
            cKeys[i] = [thisKey copy];
        } else {
            //DLog(@"********Error:NSDictionary Key DeepCopy Failed!!! ********")
            return nil;
        }
        
        ++i;
    }
    
    return [NSMutableDictionary dictionaryWithObjects:cObjects forKeys:cKeys count:count];
}


@end
