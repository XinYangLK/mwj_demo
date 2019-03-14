//
//  KLIndexView.h
//  mwstreet
//
//  Created by 科pro on 2018/12/25.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//字体变化率
#define FONT_RATE 1/8.000
//透明度变化率
#define ALPHA_RATE 1/80.0000
//初始状态索引颜色
//#define STR_COLOR MainColor

//选中状态索引颜色
#define MARK_COLOR [UIColor blackColor]
//初始状态索引大小
#define FONT_SIZE [UIFont systemFontOfSize:10]
//索引label的tag值(防止冲突)
#define TAG 233333
//圆的半径
#define ANIMATION_HEIGHT 30

typedef void (^MyBlock)(NSInteger);

@interface KLIndexView : UIView

//动画视图(可自定义)
@property (nonatomic,strong) UILabel * animationLabel;
//索引数组
@property (nonatomic,strong) NSArray * indexArray;
//滑动回调block
@property (nonatomic,copy) MyBlock selectedBlock;
//初始数值(计算用到)
@property (nonatomic,unsafe_unretained) CGFloat number;
/**
 *  index滑动反馈
 */
-(void)selectIndexBlock:(MyBlock)block;

/**
 *  初始化
 */
- (instancetype)initWithFrame:(CGRect)frame indexArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
