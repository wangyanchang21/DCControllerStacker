//
//  NSString+Common.m
//  Created by DCSnail on 15/6/18.
//

#import "NSString+Common.h"

@implementation NSString (Common)

+ (NSString *)stringFromDateTime:(NSDate*)dateTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:dateTime];
}

- (NSString *)getStringByRegex:(NSString *)regex {
    NSRegularExpression *regexExp = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:nil];
    NSRange range = [regexExp rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    if (range.length == 0) {
        return @"";
    } else {
        return [self substringWithRange:range];
    }
}

- (NSDate *)toDateByFormatter:(NSString *)formatter {
    if (self.length == 0) {
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:self];
}

- (NSDate *)toDate; {
    return [self toDateByFormatter:@"yyyy-MM-dd"];
}

- (NSDate *)toDateTime; {
    return [self toDateByFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSDate *)toFullDateTime; {
    return [self toDateByFormatter:@"yyyy-MM-dd HH:mm:ss zzz"];
}

- (NSDate *)toTime; {
    return [self toDateByFormatter:@"HH:mm:ss"];
}

- (NSString *)urlEncoded {
    NSString *encoded = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(
                                                                                             NULL,
                                                                                             (__bridge CFStringRef)self,
                                                                                             NULL,
                                                                                             (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                             kCFStringEncodingUTF8 );
    return encoded;
}

- (BOOL) isValidFileName {
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"\\/:*?\"<>|"];
    NSRange range = [self rangeOfCharacterFromSet:characterSet];
    return range.location == NSNotFound;
}

- (BOOL)isValidEmailAddress {
    BOOL stricterFilter = YES; 
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidNickName {
    NSString *regex = @"([a-zA-Z]|[0-9]|[\u4e00-\u9fa5]|_)*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject: self];
}

#if TARGET_OS_IPHONE
- (NSString *)stringByTruncatingToWidth:(CGFloat)width withFont:(UIFont *)font {
    NSString *result = [NSString stringWithString:self];
    NSDictionary *attributesDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    while ([result sizeWithAttributes:attributesDic].width > width) {
        result = [result stringByReplacingOccurrencesOfString:@"..." withString:[NSString string]];
        
        result = [[result substringToIndex:([result length] - 1)] stringByAppendingString:@"..."];
    }
    
    return result;
}
#endif

- (NSString *)reverse {
    NSMutableString *reversedString = [NSMutableString string];
    NSInteger charIndex = [self length];
    while (charIndex > 0) {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reversedString appendString:[self substringWithRange:subStrRange]];
    }
    
    return reversedString;
}

+ (NSString *)stringFromJsonArray:(NSArray *)jsonArray {
    NSString *jsonString = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray
                                                           options:kNilOptions
                                                             error:nil];
        jsonString = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

+ (NSString*)jsonStringFromDictionary:(NSDictionary *)dic {
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (NSString *)encodeToPercentEscapeString: (NSString *) input {
    NSString *outputStr = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)input, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    return outputStr;
}

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input {
    if (input == nil) {
        return nil;
    }
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [outputStr length])];
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}

@end
