//
//  NSMutableAttributedString+Extension.m
//  mwstreet
//
//  Created by 科pro on 2018/12/18.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"

@implementation NSMutableAttributedString (Extension)



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
                                         lineSpace:(NSInteger)lineSpace{
    
    if ([NSString isBlankString:string]) {
        
        return nil;
    }else{
        
        NSMutableAttributedString *inteMutStr = [self getAttributedString:string handleString:handleString handleStrFont:font handleStrColor:color];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = lineSpace;// 字体的行间距
        //字符串起始位置
        NSInteger loc = [[inteMutStr string] rangeOfString:string].location;
        //字符串长度
        NSInteger len = [[inteMutStr string] rangeOfString:string].length;
        //组合范围域
        NSRange orangeRange = NSMakeRange(loc, len);
        [inteMutStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:orangeRange];
        
        return inteMutStr;
    }
    
}





/**
 *  字符串部分字段加颜色处理
 *  param  string          整体字符串
 *  param  handleString    部分需处理字符串
 *  param  font            需处理字符串大小
 *  param  color           需处理字符串颜色
 */
+ (NSMutableAttributedString *)getAttributedString:(NSString *)string
                                      handleString:(NSString *)handleString
                                     handleStrFont:(UIFont *)font
                                    handleStrColor:(UIColor *)color {
    
    if ([NSString isBlankString:string]) {
        
         return nil;
    }else{
       
        //创建一个富文本
        NSMutableAttributedString *inteMutStr = [[NSMutableAttributedString alloc] initWithString:string];
        //字符串起始位置
        NSInteger loc = [[inteMutStr string] rangeOfString:handleString].location;
        //字符串长度
        NSInteger len = [[inteMutStr string] rangeOfString:handleString].length;
        //组合范围域
        NSRange orangeRange = NSMakeRange(loc, len);
        
        //将此范围域中字符添加颜色
        [inteMutStr addAttribute:NSForegroundColorAttributeName value:color range:orangeRange];
        //将此范围域中字符添加大小
        [inteMutStr addAttribute:NSFontAttributeName value:font range:orangeRange];

        return inteMutStr;
    }
    
}


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
                                           imgSize:(CGSize)size {
    if ([NSString isBlankString:string]) {
        
        return nil;
        
    }else{
        // 创建一个富文本
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        // 富文本文字颜色
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, string.length)];
        // 富文本文字大小
        [attributedString addAttribute:NSFontAttributeName value:fontSize range:NSMakeRange(0, string.length)];
        // 添加图片附件容器
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        // 表情图片
        attch.image = [UIImage imageNamed:imgName];
        // 设置图片大小
        attch.bounds = CGRectMake(0, 0, size.width, size.height);
        // 创建带有图片的富文本
        NSAttributedString *attributedStr = [NSAttributedString attributedStringWithAttachment:attch];
        //将图片插入相关位置
        [attributedString insertAttributedString:attributedStr atIndex:index];
        
        return attributedString;
    }
   
}

/**
 * 加删除线操作
 * @param  string          需要加删除线的字符串
 * @param  font            字符串字体大小
 * @param  color           字符串字体颜色
 */
+ (NSMutableAttributedString *)getAttributedString:(NSString *)string fontSize:(UIFont *)font stringColor:(UIColor *)color{
    
    if (![NSString isBlankString:string]) {
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
        
        [attributedString addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
                                 NSForegroundColorAttributeName:color,
                                 NSBaselineOffsetAttributeName:@(0),
                                 NSFontAttributeName: font
                                 }
                         range:[string rangeOfString:string]];
        
        return attributedString;
        
    }else{
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
        return attributedString;
    }
    

}






@end
