//
//  NSString+Pinyin.h
//  Snowball
//
//  Created by croath on 11/11/13.
//  Copyright (c) 2013 Snowball. All rights reserved.
//
// https://github.com/croath/NSString-Pinyin
//  the Chinese Pinyin string of the nsstring

#import <Foundation/Foundation.h>

@interface NSString (Pinyin)


/**
 转化为带音调的拼音字母字符串
 */
- (NSString*)pinyinWithPhoneticSymbol;

/**
 转化为拼音字母字符串
  */
- (NSString*)pinyin;

/**
 转化为去掉空格的拼音字母字符串
 */
- (NSString*)pinyinWithoutBlank;

/**
 转化为拼音首字母字符串
 */
- (NSString*)pinyinInitialsString;

/**
 转化为拼音字母字符串数组
 */
- (NSArray*)pinyinArray;

/**
 转化为拼音首字母字符串数组
 */
- (NSArray*)pinyinInitialsArray;

@end
