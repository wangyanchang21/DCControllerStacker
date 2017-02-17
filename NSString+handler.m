//
//  NSString+handler.m
//  LeZhanCloud
//
//  Created by WYC on 15/2/9.
//  Copyright (c) 2015年 WYC. All rights reserved.
//

#import "NSString+handler.h"

@implementation NSString (handler)

/**
 *  @brief  判断URL中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)isContainChinese
{
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

/**
 *  @brief  是否包含空格
 *
 *  @return 是否包含空格
 */
- (BOOL)isContainBlank
{
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

//Unicode编码的字符串转成NSString
- (NSString *)makeUnicodeToString
{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    //NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}


/**
 是否包含当前CharacterSet

 @param set CharacterSet
 @return 是否包含
 */
- (BOOL)containsCharacterSet:(NSCharacterSet *)set
{
    NSRange rang = [self rangeOfCharacterFromSet:set];
    if (rang.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

/**
 *  @brief 是否包含字符串
 *
 *  @param string 字符串
 *
 *  @return YES, 包含; Otherwise
 */
- (BOOL)containsaString:(NSString *)string
{
    NSRange rang = [self rangeOfString:string];
    if (rang.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

/**
 *  @brief 获取字符数量
 */
- (int)wordsCount
{
    NSInteger n = self.length;
    int i;
    int l = 0, a = 0, b = 0;
    unichar c;
    for (i = 0; i < n; i++)
    {
        c = [self characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a == 0 && l == 0) {
        return 0;
    }
    return l + (int)ceilf((float)(a + b) / 2.0);
}

/*!
 *  判断邮箱号是否合法
 *
 *  @return 邮箱是否合法
 *
 *  @since 1.0
 */
-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/*!
 *  判断手机号是否合法
 *
 *  @return 手机号是否合法 YES / NO
 *
 *  @since 1.0
 */
-(BOOL)isValidateMobile
{
    //手机号以13、15、18、 14、17开头，中间一位，八个 \d 数字字符
    NSString *phoneRegex = @"^1[34578]\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    if (self.length != 11) {
        return NO;
    }
    return [phoneTest evaluateWithObject:self];
}


/**
 *  判断是否只包含数组
 *
 *  @param number 单个字符
 *
 *  @return 只包含数字返回 YES, 否则返回 NO
 */- (BOOL)validateOnlyNumber
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < self.length) {
        NSString * string = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return ceil(textSize.height);
}

/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return ceil(textSize.width);
}

/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)reverseString:(NSString *)strSrc
{
    NSMutableString* reverseString = [[NSMutableString alloc] init];
    NSInteger charIndex = [strSrc length];
    while (charIndex > 0) {
        charIndex --;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reverseString appendString:[strSrc substringWithRange:subStrRange]];
    }
    return reverseString;
}

/**
 *  @brief  JSON字符串转成NSDictionary
 *
 *  @return NSDictionary
 */
-(NSDictionary *) dictionaryValue{
    NSError *errorJson;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&errorJson];
    if (errorJson != nil) {
#ifdef DEBUG
        NSLog(@"fail to get dictioanry from JSON: %@, error: %@", self, errorJson);
#endif
    }
    return jsonDict;
}

/**
 *  @brief  xml字符串转换成NSDictionary
 *
 *  @return NSDictionary
 */
-(NSDictionary *)dictionaryFromXML
{
    //TURN THE STRING INTO DATA
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    //INTIALIZE NECESSARY HELPER VARIABLES
    self.currentDictionaries = [[NSMutableArray alloc] init] ;
    self.currentText = [[NSMutableString alloc] init];
    
    //INITIALIZE WITH A DICTIONARY TO START WITH
    [self.currentDictionaries addObject:[NSMutableDictionary dictionary]];
    
    //DO PARSING
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    BOOL success = [parser parse];
    
    //RETURNS
    if(success)
        return [self.currentDictionaries objectAtIndex:0];
    else
        return nil;
}

#pragma mark -
#pragma mark ASSOCIATIVE OVERRIDES

- (void)setCurrentDictionaries:(NSMutableArray *)currentDictionaries
{
    objc_setAssociatedObject(self, ASSOCIATIVE_CURRENT_DICTIONARY_KEY, currentDictionaries, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray *)currentDictionaries
{
    return objc_getAssociatedObject(self, ASSOCIATIVE_CURRENT_DICTIONARY_KEY);
}

- (void)setCurrentText:(NSMutableString *)currentText
{
    objc_setAssociatedObject(self, ASSOCIATIVE_CURRENT_TEXT_KEY, currentText, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableString *)currentText
{
    return objc_getAssociatedObject(self, ASSOCIATIVE_CURRENT_TEXT_KEY);
}

#pragma mark -
#pragma mark NSXMLPARSER DELEGATE

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //GET THE LAST DICTIONARY
    NSMutableDictionary *parent = [self.currentDictionaries lastObject];
    
    //CREATE A NEW DICTIONARY AND SET ALL THE ATTRIBUTES
    NSMutableDictionary *child = [NSMutableDictionary dictionary];
    [child addEntriesFromDictionary:attributeDict];
    
    id currentValue = [parent objectForKey:elementName];
    
    //SHOULD BE AN ARRAY IF WE ALREADY HAVE ONE FOR THIS KEY, OTHERWISE JUST ADD IT IN
    if (currentValue)
    {
        NSMutableArray *array = nil;
        
        //IF CURRENTVALUE IS ALREADY AN ARRAY USE IT, OTHERWISE, MAKE ONE
        if ([currentValue isKindOfClass:[NSMutableArray class]])
            array = (NSMutableArray *) currentValue;
        else
        {
            array = [NSMutableArray array];
            [array addObject:currentValue];
            
            //REPLACE DICTIONARY WITH ARRAY IN PARENT
            [parent setObject:array forKey:elementName];
        }
        
        [array addObject:child];
    }
    else
        [parent setObject:child forKey:elementName];
    
    //ADD NEW OBJECT
    [self.currentDictionaries addObject:child];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //UPDATE PARENT INFO
    NSMutableDictionary *dictInProgress = [self.currentDictionaries lastObject];
    
    if ([self.currentText length] > 0)
    {
        //REMOVE WHITE SPACE
        [dictInProgress setObject:self.currentText forKey:@"text"];
        
        self.currentText = nil;
        self.currentText = [[NSMutableString alloc] init];
    }
    
    //NO LONGER NEED THIS DICTIONARY, AS WE'RE DONE WITH IT
    [self.currentDictionaries removeLastObject];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.currentText appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    //WILL RETURN NIL FOR ERROR
}


@end
