//
//  NSString+Common.h
//  Created by DCSnail on 15/6/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Common)


/*
 time: @"HH:mm:ss"
 date: @"yyyy-MM-dd"
 dateTime: @"yyyy-MM-dd HH:mm:ss"
 fullDateTime: @"yyyy-MM-dd HH:mm:ss zzz"
 */

+ (NSString *)stringFromDateTime:(NSDate*)dateTime;
- (NSDate *)toDateByFormatter:(NSString *)formatter;
- (NSDate *)toDate;
- (NSDate *)toDateTime;
- (NSDate *)toFullDateTime;
- (NSDate *)toTime;

- (NSString *)getStringByRegex:(NSString *)regex;

- (NSString *)urlEncoded;

- (NSString *)reverse;

#if TARGET_OS_IPHONE
- (NSString *)stringByTruncatingToWidth:(CGFloat)width withFont:(UIFont *)font;
#endif

- (BOOL)isValidFileName;
- (BOOL)isValidEmailAddress;
- (BOOL)isValidNickName;

+ (NSString *)stringFromJsonArray:(NSArray *)jsonArray;
+ (NSString*)jsonStringFromDictionary:(NSDictionary *)dic;

+ (NSString *)encodeToPercentEscapeString:(NSString *)input;
+ (NSString *)decodeFromPercentEscapeString:(NSString *)input;



@end
