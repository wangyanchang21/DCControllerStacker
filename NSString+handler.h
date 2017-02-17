//
//  NSString+handler.h
//  LeZhanCloud
//
//  Created by WYC on 15/2/9.
//  Copyright (c) 2015年 WYC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (handler)


/**
 *  @brief  判断URL中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)isContainChinese;

/**
 *  @brief  是否包含空格
 *
 *  @return 是否包含空格
 */
- (BOOL)isContainBlank;

/**
 *  @brief  Unicode编码的字符串转成NSString
 *
 *  @return Unicode编码的字符串转成NSString
 */
- (NSString *)makeUnicodeToString;

/**
 是否包含当前CharacterSet
 
 @param set CharacterSet
 @return 是否包含
 */
- (BOOL)containsCharacterSet:(NSCharacterSet *)set;

/**
 *  @brief 是否包含字符串
 *
 *  @param string 字符串
 *
 *  @return YES, 包含;
 */
- (BOOL)containsaString:(NSString *)string;

/**
 *  @brief 获取字符数量
 */
- (int)wordsCount;

/*!
 *  判断邮箱号是否合法
 *
 *  @return 邮箱是否合法
 *
 *  @since 1.0
 */
-(BOOL)isValidateEmail;

/*!
 *  判断手机号是否合法
 *
 *  @return 手机号是否合法 YES / NO
 *
 *  @since 1.0
 */
-(BOOL)isValidateMobile;

/**
 *  判断是否只包含数字
 *
 *  @param number 单个字符
 *
 *  @return 只包含数字返回 YES, 否则返回 NO
 */
- (BOOL)validateOnlyNumber;

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)reverseString:(NSString *)strSrc;

/**
 *  @brief  JSON字符串转成NSDictionary
 *
 *  @return NSDictionary
 */
-(NSDictionary *) dictionaryValue;

/**
 *  @brief  xml字符串转换成NSDictionary
 *
 *  @return NSDictionary
 */
-(NSDictionary *)dictionaryFromXML;


@end
