//
//  UILabel+Category.h
//  mwstreet
//
//  Created by 科pro on 2018/12/18.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Category)

//***   字间距  **/
@property (nonatomic,assign)CGFloat characterSpace;

//***  行间距  **/
@property (nonatomic,assign)CGFloat lineSpace;

//***  关键字  **/
@property (nonatomic,copy)NSString *keywords;

//***  关键字体大小  **/
@property (nonatomic,strong)UIFont *keywordsFont;

//***  关键字体t颜色 **/
@property (nonatomic,strong)UIColor *keywordsColor;

//***  下划线  **/
@property (nonatomic,copy)NSString *underlineStr;

//***  下划线t颜色  **/
@property (nonatomic,strong)UIColor *underlineColor;

/**
 *  计算label宽高，必须调用
 *  @param maxWidth 最大宽度
 *  @return label的rect
 */
- (CGSize)getLableRectWithMaxWidth:(CGFloat)maxWidth;

/**
 * 左右两端对齐
 * @param  labelWidth  label宽度
 * （NSTextAlignmentJustified是最后一行自然对齐）
 */
- (void)labelAlightLeftAndRightWithWidth:(CGFloat)labelWidth;


/**
 *  计算label宽
 *  param  title           需处理字符串
 *  param  font            字符串字号
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;


/**
 * 创建lable
 * @param  titleColor  字体颜色
 * @param  font        字大小
 */
+ (UILabel *)createLabelTextColor:(UIColor *)titleColor font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
