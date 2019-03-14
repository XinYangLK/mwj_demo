//
//  NSMutableAttributedString+Extension.h
//  mwstreet
//
//  Created by 科pro on 2018/12/18.
//  Copyright © 2018 xunben. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (Extension)

/**
 *  字符串部分字段加颜色处理
 *  param  string          整体字符串
 *  param  handleString    部分需处理字符串
 *  param  font            需处理字符串大小
 *  param  color           需处理字符串颜色
 *  param  lineSpace       行间距
 */
+ (NSMutableAttributedString *)getAttributedString:(NSString *)string
                                      handleString:(NSString *)handleString
                                     handleStrFont:(UIFont *)font
                                    handleStrColor:(UIColor *)color
                                         lineSpace:(NSInteger)lineSpace;

/**
 *  字符串部分字段加颜色处理
 *  param  string          整体字符串
 *  param  handleString    部分需处理字符串
 *  param  font            需处理字符串大小
 *  param  Color           需处理字符串颜色
 */
+ (NSMutableAttributedString *)getAttributedString:(NSString *)string
                                      handleString:(NSString *)handleString
                                     handleStrFont:(UIFont *)font
                                    handleStrColor:(UIColor *)color;

/**
 * lable 图文混排
 * @param  string         文字信息
 * @param  color          文字颜色
 * @param  fontSize       文字大小
 * @param  index          图片位置  ( 0 -> string.length )
 * @param  imgName        图片名称
 * @param  size           图片大小
 */
+ (NSMutableAttributedString *)getAttributedString:(NSString *)string
                                       stringColor:(UIColor *)color
                                           strFont:(UIFont *)fontSize
                                             index:(NSInteger)index
                                           imgName:(NSString *)imgName
                                           imgSize:(CGSize)size;



/**
 * 加删除线操作
 * @param  string          需要加删除线的字符串
 * @param  font            字符串字体大小
 * @param  color           字符串字体颜色
 */
+ (NSMutableAttributedString *)getAttributedString:(NSString *)string
                                          fontSize:(UIFont *)font
                                       stringColor:(UIColor *)color;


@end

NS_ASSUME_NONNULL_END
