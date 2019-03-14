//
//  UIView+Extension.m
//  mwstreet
//
//  Created by 科pro on 2018/12/18.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

/**
 * 设置控件圆角
 */
- (void)setLayerCornerRadius:(CGFloat)cornerRadius{
    
    [self setLayerCornerRadius:cornerRadius borderWidth:0 borderColor:[UIColor clearColor]];
}


/**
 * 设置圆角边线和边线颜色
 */
- (void)setLayerCornerRadius:(CGFloat)cornerRadius
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor {
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

- (void)clipCornViewWith:(UIRectCorner)corners withCornRad:(CGSize)cornerRadii
{
    //设置子视图的圆角
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.frame = self.bounds;
    shapLayer.path = path.CGPath;
    [self.layer addSublayer:shapLayer];
    self.layer.mask = shapLayer;
    
}


/**
 * 设置边框阴影
 */
- (void)setShadowColor:(UIColor *)color{
    //阴影透明度
    self.layer.shadowOpacity = 1;
    //阴影颜色
    self.layer.shadowColor = color.CGColor;
    //阴影偏移 //
    self.layer.shadowOffset = CGSizeMake(0, 0);
}



/**
 * 获取最底部view 的bottom值
 * @param  view 要处理的父 View
 * @return bottom
 */
+ (CGFloat)getBottomViewBottomFrom:(UIView *)view {
    NSArray * views= [view.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView *view1 , UIView * view2){
        NSString * top1 = [NSString stringWithFormat:@"%f",view1.frame.origin.y];
        NSString * top2 = [NSString stringWithFormat:@"%f",view2.frame.origin.y];
        NSComparisonResult result = [top1 compare:top2 options:NSNumericSearch];
        //降序 从小到大
        return result == NSOrderedDescending;
    }];
    UIView * bottomView = views.lastObject;
    return bottomView.frame.origin.y+bottomView.frame.size.height;
}


/**
 * Push 过度动画
 */
+ (void)pushOrPopAnimationType:(CATransitionSubtype)type
                          view:(UIWindow *)window {
    //创建动画
    CATransition *animation = [CATransition animation];
    //动画时间
    animation.duration = 0.25f;
    //动画速率类型
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //过渡效果
    animation.type = kCATransitionPush;
    //过渡方向
    animation.subtype = type;
    //添加动画
    [window.layer addAnimation:animation forKey:nil];
}





- (CGFloat)left{
    return self.frame.origin.x;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (CGFloat)right{
    return self.frame.origin.x+self.frame.size.width;
}

- (CGFloat)bottom{
    return self.frame.origin.y+self.frame.size.height;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (CGFloat)centerY{
    return self.center.y;
}

-(CGFloat)max_X{
    return self.frame.origin.x+self.frame.size.width;
}
-(CGFloat)max_Y{
    return self.frame.origin.y+self.frame.size.height;
}

- (void)setMax_X:(CGFloat)max_X{
    CGRect frame= self.frame;
    frame.size.width= max_X;
    self.frame=frame;
}

- (void)setMax_Y:(CGFloat)max_Y{
    CGRect frame=self.frame;
    frame.size.height= max_Y;
    self.frame=frame;
}

- (void)setLeft:(CGFloat)left{
    CGRect frame=self.frame;
    frame.origin.x=left;
    self.frame=frame;
}

- (void)setTop:(CGFloat)top{
    CGRect frame=self.frame;
    frame.origin.y=top;
    self.frame=frame;
}

- (void)setRight:(CGFloat)right{
    CGRect frame=self.frame;
    frame.origin.x=right-self.width;
    self.frame=frame;
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame=self.frame;
    frame.origin.y=bottom-self.height;
    self.frame=frame;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center=self.center;
    center.y=centerY;
    self.center=center;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center=self.center;
    center.x=centerX;
    self.center=center;
}



@end
