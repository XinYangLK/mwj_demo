//
//  UIButton+Extention.h
//  mwstreet
//
//  Created by 科pro on 2018/12/19.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^tapActionBlock)(UIButton *button);

@interface UIButton (Extension)

@property(nonatomic,copy)tapActionBlock actionBlock;

/**
 * 通过block对button的点击事件封装
 * @param title              标题
 * @param titleColor         字体颜色
 * @param font               字体大小
 * @param imgName            图片
 * @param backColor          背景单色图片
 * @param actionBlock        点击事件回调block
  @return button
 */
+ (UIButton *)createBtnTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imgName backgrounColor:(UIColor *)backColor action:(tapActionBlock)actionBlock;



/**
 * 通过block对button的点击事件封装
 * @param title              标题
 * @param titleColor         字体颜色
 * @param font               字体大小
 * @param imgName            图片
 * @param backColor          背景单色图片
 * @param type               图片-字体，上，下，左，右类型
 * @param spac               图片-字体 间距
 * @param actionBlock        点击事件回调block
 @return button
 */
+ (UIButton *)createBtnTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imgName backgrounColor:(UIColor *)backColor SSImagePositionType:(SSImagePositionType)type spacing:(CGFloat)spac action:(tapActionBlock)actionBlock;
    
@end

NS_ASSUME_NONNULL_END
