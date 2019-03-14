//
//  KLCountdownView.m
//  mwstreet
//
//  Created by 科pro on 2018/12/21.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLCountdownView.h"
@interface KLCountdownView ()
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, strong) UIFont *font;
@end
@implementation KLCountdownView

- (instancetype)initWithFrame:(CGRect)frame size:(CGFloat)size{
    self =[super initWithFrame:frame];
    if (self) {
        self.size = size;
        self.font =(size == AdaptedWidth(22) ? kFont_12 : kFont_10);
        [self configUI];
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    self.hourLabel.backgroundColor = color;
    self.minuteLabel.backgroundColor = color;
    self.secondLabel.backgroundColor = color;
    self.separator.textColor = color;
    self.separator2.textColor = color;
}

//***  UI 布局  **/
- (void)configUI{
    
    [self addSubview:self.hourLabel];
    [self addSubview:self.separator];
    [self addSubview:self.minuteLabel];
    [self addSubview:self.separator2];
    [self addSubview:self.secondLabel];
    
    [self.hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.top.offset = 0;
        make.height.width.offset = self.size;
    }];
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hourLabel.mas_right).offset =AdaptedWidth(2);
        make.height.offset =AdaptedHeight(20);
        make.width.offset =AdaptedWidth(10);
        make.centerY.mas_equalTo(self.hourLabel);
    }];
    [self.minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.separator.mas_right).offset =AdaptedWidth(2);
        make.height.width.centerY.mas_equalTo(self.hourLabel);
    }];
    [self.separator2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.minuteLabel.mas_right).offset =AdaptedWidth(2);
        make.height.width.centerY.mas_equalTo(self.separator);
    }];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.separator2.mas_right).offset =AdaptedWidth(2);
        make.height.width.centerY.mas_equalTo(self.hourLabel);
    }];

}

// 小时
- (UILabel *)hourLabel{
    if (!_hourLabel){
        _hourLabel = [UILabel createLabelTextColor:RGBSigle(255) font:self.font];
        _hourLabel.backgroundColor = RGBSigle(51);
        _hourLabel.text =@"00";
        [_hourLabel setLayerCornerRadius:5];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _hourLabel;
}
// 分割符
- (UILabel *)separator{
    if (!_separator){
        _separator = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_15];
        _separator.text =@":";
        _separator.textAlignment = NSTextAlignmentCenter;
        
    }
    return _separator;
}
// 分钟
- (UILabel *)minuteLabel{
    if (!_minuteLabel){
        _minuteLabel = [UILabel createLabelTextColor:RGBSigle(255) font:self.font];
        _minuteLabel.text =@"00";
        [_minuteLabel setLayerCornerRadius:5];
        _minuteLabel.textAlignment = NSTextAlignmentCenter;
        _minuteLabel.backgroundColor = RGBSigle(51);
        
    }
    return _minuteLabel;
}
// 分割符
- (UILabel *)separator2{
    if (!_separator2){
        _separator2 = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_15];
        _separator2.text =@":";
        _separator2.textAlignment = NSTextAlignmentCenter;
    }
    return _separator2;
}
// 秒数
- (UILabel *)secondLabel{
    if (!_secondLabel){
        _secondLabel = [[UILabel alloc]init];
        _secondLabel = [UILabel createLabelTextColor:RGBSigle(255) font:self.font];
        _secondLabel.backgroundColor = RGBSigle(51);
        _secondLabel.text =@"00";
        [_secondLabel setLayerCornerRadius:5];
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _secondLabel;
}

@end
