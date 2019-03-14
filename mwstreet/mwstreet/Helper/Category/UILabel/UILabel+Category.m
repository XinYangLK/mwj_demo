//
//  UILabel+Category.m
//  mwstreet
//
//  Created by 科pro on 2018/12/18.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "UILabel+Category.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

@implementation UILabel (Category)

//***  字间距  **/
-(CGFloat)characterSpace{
    return [objc_getAssociatedObject(self,_cmd) floatValue];
}

-(void)setCharacterSpace:(CGFloat)characterSpace{
    objc_setAssociatedObject(self, @selector(characterSpace), @(characterSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


//***   行间距  **/
-(CGFloat)lineSpace{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setLineSpace:(CGFloat)lineSpace{
    objc_setAssociatedObject(self, @selector(lineSpace), @(lineSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


//***  关键字  **/
-(NSString *)keywords{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setKeywords:(NSString *)keywords{
    objc_setAssociatedObject(self, @selector(keywords), keywords, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


//***  关键字大小 **/
-(UIFont *)keywordsFont{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setKeywordsFont:(UIFont *)keywordsFont{
    objc_setAssociatedObject(self, @selector(keywordsFont), keywordsFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


//***  关键字颜色 **/
-(UIColor *)keywordsColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setKeywordsColor:(UIColor *)keywordsColor{
    objc_setAssociatedObject(self, @selector(keywordsColor), keywordsColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


//***  下划线  **/
-(NSString *)underlineStr{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setUnderlineStr:(NSString *)underlineStr{
    objc_setAssociatedObject(self, @selector(underlineStr), underlineStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


//***  下划线颜色  **/
-(UIColor *)underlineColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setUnderlineColor:(UIColor *)underlineColor{
    objc_setAssociatedObject(self, @selector(underlineColor), underlineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


/**
 *  根据最大宽度计算label宽，高
 *  @param maxWidth 最大宽度
 *  @return rect
 */
- (CGSize)getLableRectWithMaxWidth:(CGFloat)maxWidth{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    
    [attributedString addAttribute:NSFontAttributeName
                             value:self.font
                             range:NSMakeRange(0,self.text.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.alignment=self.textAlignment;
    
    paragraphStyle.lineBreakMode=self.lineBreakMode;
    // 行间距
    if(self.lineSpace > 0){
        
        [paragraphStyle setLineSpacing:self.lineSpace];
        
        [attributedString addAttribute:NSParagraphStyleAttributeName
                                 value:paragraphStyle
                                 range:NSMakeRange(0,self.text.length)];
    }
    // 字间距
    if(self.characterSpace > 0){
        
        long number = self.characterSpace;
        
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt64Type,&number);
        
        [attributedString addAttribute:(id)kCTKernAttributeName
                                 value:(__bridge id)num
                                 range:NSMakeRange(0,[attributedString length])];
        
        CFRelease(num);
    }
    //关键字
    if (self.keywords) {
        
        NSRange itemRange = [self.text rangeOfString:self.keywords];
        
        if (self.keywordsFont) {
            
            [attributedString addAttribute:NSFontAttributeName
                                     value:self.keywordsFont
                                     range:itemRange];
        }
        
        if (self.keywordsColor) {
            
            [attributedString addAttribute:NSForegroundColorAttributeName
                                     value:self.keywordsColor
                                     range:itemRange];
        }
    }
    //下划线
    if (self.underlineStr) {
        
        NSRange itemRange = [self.text rangeOfString:self.underlineStr];
        
        [attributedString addAttribute:NSUnderlineStyleAttributeName
                                 value:@(NSUnderlineStyleSingle)
                                 range:itemRange];
        
        if (self.underlineColor) {
            
            [attributedString addAttribute:NSUnderlineColorAttributeName
                                     value:self.underlineColor
                                     range:itemRange];
        }
    }
    self.attributedText = attributedString;
    //计算方法一
    CGSize maximumLabelSize = CGSizeMake(maxWidth, MAXFLOAT);//labelsize的最大值
    
    CGSize expectSize = [self sizeThatFits:maximumLabelSize];
    
    return expectSize;
}


/**
 *  param  title          需处理字符串
 *  param  font           字符串字号
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}





#pragma mark ------ 左右两端对齐（NSTextAlignmentJustified是最后一行自然对齐）

-(void)labelAlightLeftAndRightWithWidth:(CGFloat)labelWidth {
    //自适应高度
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin |
                                                      NSStringDrawingTruncatesLastVisibleLine|
                                                      NSStringDrawingUsesFontLeading
                                           attributes:@{NSFontAttributeName :self.font}
                                              context:nil].size;
    
    CGFloat margin = (labelWidth - textSize.width)/(self.text.length - 1);
    
    NSNumber *number = [NSNumber numberWithFloat:margin];
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:self.text];
    //字间距 :NSKernAttributeName
    [attribute addAttribute:NSKernAttributeName
                      value:number
                      range:NSMakeRange(0, self.text.length - 1)];
    
    self.attributedText = attribute;
}



+ (UILabel *)createLabelTextColor:(UIColor *)titleColor font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc]init];;
    label.font = font;
    label.textColor = titleColor;
    
    return label;
    
}


@end
