//
//  NSString+Extension.h
//  mwstreet
//
//  Created by 科pro on 2018/12/18.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)


/**
 * 判断字符串是否为空
 * runturn  YES -> nil
 * runturn  NO  -> non-Null
 */
+ (BOOL) isBlankString:(NSString *)string;

+ (NSString *)wy_emptyStr:(NSString *)str;

/**
 * 判断手机号码格式是否正确
 * runturn  YES -> 正确
 * runturn  NO  -> 错误
 */
+ (BOOL)isValidaMoblieNumber:(NSString *)telPhone;


/**
 * 过滤空字符中空格
 */
+ (NSString *)getWithFilteringStringSpace:(NSString *)string;


/**
 * 将为空字符串赋值"--"
 */
+ (NSString *)getBlankString:(NSString *)string;


/**
 * 将为空字符串赋值"-&&-"
 * @param  string                   需要判断的字符串
 * @param  placeholder              占位字符
 */
+ (NSString *)getBlankString:(NSString *)string
                 placeholder:(NSString *)placeholder;



/**
 * 金额小数点分隔格式化处理
 */
+ (NSString *)getNumberFormatterString:(NSString *)numberStr;



/**
 *  电话号加＊处理
 *  param  originalStr     需处理字符串
 *  param  startLocation   起始位
 *  param  lenght          *号长度
 */
+ (NSString *)getReplaceStringWithAsterisk:(NSString *)originalString
                             startLocation:(NSInteger)startLocation
                            asteriskLenght:(NSInteger)lenght;


/**
 * 时间戳转化成时间
 */
+ (NSString *)getTimeTransformationTimestamp:(NSString *)timeString;


/**
 * 时间戳转换字符串
 */
+ (NSString *)timestampToString;


//传入 秒  得到 xx:xx:xx
+ (NSString *)getMMSSFromSS:(NSString *)totalTime;

/**
 * 字典key升序排列
 */
+ (NSString *)getSignWithDictionary:(NSDictionary *)dictionary;


/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 根据文字计算宽度
 @param string 文字
 @param height 高度
 @param font 文字大小
 @return 返回的宽度
 */
+ (CGFloat)calculateRowWidth:(NSString *)string withHeight:(NSInteger)height font:(NSInteger)font;


/**
 *  除去非数字字符，确定光标正确位置
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理过后的string
 */
+ (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition;



/**
 *  将空格插入我们现在的string 中，并确定我们光标的正确位置，防止在空格中
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理后有空格的string
 */
+ (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition;
@end

NS_ASSUME_NONNULL_END
