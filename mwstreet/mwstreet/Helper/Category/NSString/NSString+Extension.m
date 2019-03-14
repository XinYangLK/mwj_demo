//
//  NSString+Extension.m
//  mwstreet
//
//  Created by 科pro on 2018/12/18.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Extension)


/**
 * 判断字符串是否为空
 * runturn  YES -> nil
 * runturn  NO  -> non-Null
 */

+ (BOOL) isBlankString:(NSString *)string {
    
    if ([string isKindOfClass:[NSNull class]]) {
       
        return YES;
    }
    
    if (string == nil || string == NULL || [string  isEqual: @"(null)"] || [string isEqual:@"<null>"]) {
       
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
       
        return YES;
        
    }
    return NO;
}




/**
 * 判断手机号码格式是否正确
 * runturn  YES -> 正确
 * runturn  NO  -> 错误
 */
+ (BOOL) isValidaMoblieNumber:(NSString *)telPhone {
    
    telPhone =[NSString getWithFilteringStringSpace:telPhone];
    
    if (telPhone.length != 11){
        
        return NO;
        
    }else if(![[telPhone substringToIndex:1] isEqualToString:@"1"]){
        
        return NO;
        
    }else{
        
        return YES;
        
    }
}
+ (NSString *)wy_emptyStr:(NSString *)str {
    
    if(([str isKindOfClass:[NSNull class]]) || ([str isEqual:[NSNull null]]) || (str == nil) || (!str)) {
        
        str = @"";
    }
    return str;
}


/**
 * 过滤空字符中空格
 */
+ (NSString *)getWithFilteringStringSpace:(NSString *)string {
    
    //过滤前后空格
    NSString *strText =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //过滤中间空格
    NSString *textStr =[strText stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return textStr;
}



/**
 * 将为空字符串赋值"--"
 */

+ (NSString *)getBlankString:(NSString *)string {

   return [NSString getBlankString:string placeholder:@"--"];
}

/**
 * 将为空字符串赋值"-&&-"
 * @param  string                   需要判断的字符串
 * @param  placeholder              占位字符
 */
+ (NSString *)getBlankString:(NSString *)string
                 placeholder:(NSString *)placeholder {
   
    if ([NSString isBlankString:string]==YES) {
        
        return placeholder;
        
    }else{
        
        return string;
    }
}



/**
 * 金额分隔格式化处理
 */
+ (NSString *)getNumberFormatterString:(NSString *)numberStr{
    
    if ([NSString isBlankString:numberStr]) {
        
        return  @"0.00";
        
    }
    //小数点后两位
    NSDecimalNumberHandler*roundUp = [NSDecimalNumberHandler
                                      decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                      scale:2
                                      raiseOnExactness:NO
                                      raiseOnOverflow:NO
                                      raiseOnUnderflow:NO
                                      raiseOnDivideByZero:YES];
    
    NSDecimalNumber*subtotal = [[NSDecimalNumber alloc]initWithString:numberStr];
    
    NSDecimalNumber*discount = [[NSDecimalNumber alloc]initWithFloat:1.00];
    
    NSDecimalNumber*total = [subtotal decimalNumberByMultiplyingBy:discount
                             
                                                      withBehavior:roundUp];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    
    NSString *formattedNumberString = [numberFormatter stringFromNumber:total];
    
    return formattedNumberString;
    
}


/**
 *  电话号加＊处理
 *  param  originalStr     需处理字符串
 *  param  startLocation   起始位
 *  param  lenght          *号长度
 */
+ (NSString *)getReplaceStringWithAsterisk:(NSString *)originalString
                             startLocation:(NSInteger)startLocation
                            asteriskLenght:(NSInteger)lenght {
   
    NSString *newString = originalString;
    
    if (originalString.length>0) {
        
        for (int i = 0; i < lenght; i++) {
            
            NSRange range = NSMakeRange(startLocation, 1);
            
            newString = [newString stringByReplacingCharactersInRange:range withString:@"*"];
            
            startLocation ++;
        }
        
        return newString;
        
    }else{
        
        return [NSString getBlankString:newString];
    }
}




/**
 * 时间戳转化成时间
 */
+ (NSString *)getTimeTransformationTimestamp:(NSString *)timeString {
    
    NSString * sting = [NSString stringWithFormat:@"%@",timeString];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[sting intValue]];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *confromTimespStr = [formatter stringFromDate:date];
    
    return confromTimespStr;
}

/**
 * 时间戳转换字符串
 */
+ (NSString *)timestampToString {
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    
    return timeString;
}

//传入 秒  得到 xx:xx:xx
+ (NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
    
}


/**
 * 字典key升序排列
 */

+ (NSString *)getSignWithDictionary:(NSDictionary *)dictionary {
    
    NSMutableArray *stringArray = [NSMutableArray arrayWithArray:dictionary.allKeys];
    
    [stringArray sortUsingComparator: ^NSComparisonResult (NSString *str1, NSString *str2) {
        
        return [str1 compare:str2];
        
    }];
    NSMutableArray * singArray = [NSMutableArray arrayWithCapacity:0];
    // 排序后封装字符串
    [stringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString * oneStr = [NSString stringWithFormat:@"%@=%@",obj,dictionary[obj]];
        
        [singArray addObject:oneStr];
        
    }];
    NSString * singstr = [singArray componentsJoinedByString:@"&"];
    //封装后字符串加密
    NSString * sha1   = [NSString sha1:singstr];
    
    NSString * key    = @"#l_vle_ll_e%+$^@0608)[";
    
    NSString * string = [NSString stringWithFormat:@"%@%@",sha1,key];
    
    NSString * cipher = [string md5String];
   
    return cipher;
}






#pragma mark ------- <CommonCrypto/CommonCrypto.h>


/**
 * HMAC
 * sha256 加密算法
 */

+ (NSString *)hmacSha256:(NSString *)key text:(NSString *)data{
    
    NSString *encodedString = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,(CFStringRef)data, nil,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    const char *cData = [encodedString cStringUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSString *hash;
    
    NSMutableString *output =[NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    
    for (int i =0; i<CC_SHA256_DIGEST_LENGTH; i++) {
        
        [output appendFormat:@"%02x",cHMAC[i]];
        
        hash =output;
    }
    
    return hash;
}



/**
 *  HMAC
 *  sha1 加密
 */
+ (NSString *)sha1:(NSString *)input {
    
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        
        [output appendFormat:@"%02x", digest[i]];
        
    }
    return output;
}



/**
 * MD5加密算法
 * 散列函数
 */
- (NSString *)md5String {
    
    const char *str = self.UTF8String;
    
    unsigned char buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length {
    
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        
        [strM appendFormat:@"%02x", bytes[i]];
    }
    return [strM copy];
}





- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


+ (CGFloat)calculateRowWidth:(NSString *)string withHeight:(NSInteger)height font:(NSInteger)font {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, height)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}



/**
 *  除去非数字字符，确定光标正确位置
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理过后的string
 */
+ (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition =*cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    
    for (NSUInteger i=0; i<string.length; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        
        if(isdigit(characterToAdd)) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if(i<originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    return digitsOnlyString;
}

/**
 *  将空格插入我们现在的string 中，并确定我们光标的正确位置，防止在空格中
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理后有空格的string
 */
+ (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition{
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    
    for (NSUInteger i=0; i<string.length; i++) {
        if(i>0)
        {
            if(i==3 || i==7) {
                [stringWithAddedSpaces appendString:@" "];
                
                if(i<cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }
        
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}



@end
