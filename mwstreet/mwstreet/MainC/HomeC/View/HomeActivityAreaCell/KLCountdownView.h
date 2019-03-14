//
//  KLCountdownView.h
//  mwstreet
//
//  Created by 科pro on 2018/12/21.
//  Copyright © 2018 xunben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLCountdownView : UIView
// 小时
@property (strong, nonatomic) UILabel         * hourLabel;
// 分割符
@property (nonatomic, strong) UILabel         * separator;
// 分钟
@property (strong, nonatomic) UILabel         * minuteLabel;
// 分割符
@property (nonatomic, strong) UILabel         * separator2;
// 秒数
@property (strong, nonatomic) UILabel         * secondLabel;

@property (nonatomic, strong) UIColor         * color;

//size  倒计时方块大小
- (instancetype)initWithFrame:(CGRect)frame size:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
