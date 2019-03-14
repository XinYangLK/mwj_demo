//
//  UIView+Extension.h
//  mwstreet
//
//  Created by 科pro on 2018/12/18.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)

@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (assign,nonatomic) CGFloat max_Y;
@property (assign,nonatomic) CGFloat max_X;


/**
 * 设置控件圆角
 */
- (void)setLayerCornerRadius:(CGFloat)cornerRadius;


/**
 * 设置圆角边线和边线颜色
 */
- (void)setLayerCornerRadius:(CGFloat)cornerRadius
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor;

- (void)clipCornViewWith:(UIRectCorner)corners withCornRad:(CGSize)cornerRadii;

/**
 * 设置边框阴影
 */
- (void)setShadowColor:(UIColor *)color;



/**
 * 获取最底部view 的bottom值
 * @param  view 要处理的父 View
 * @return bottom
 */
+ (CGFloat)getBottomViewBottomFrom:(UIView *)view;



/**
 * Push 过度动画
 */
+ (void)pushOrPopAnimationType:(CATransitionSubtype)type
                          view:(UIWindow *)window;


@end

NS_ASSUME_NONNULL_END
