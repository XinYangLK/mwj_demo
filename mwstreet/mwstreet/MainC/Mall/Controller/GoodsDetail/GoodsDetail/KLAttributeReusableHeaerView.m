//
//  KLAttributeReusableHeaerView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/10.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLAttributeReusableHeaerView.h"

@implementation KLAttributeReusableHeaerView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLab];
        [self addSubview:self.alertLab];
    }
    return self;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel createLabelTextColor:TitleColor font:kFont_14];
        _titleLab.frame =CGRectMake(AdaptedWidth(10), 0, AdaptedWidth(50), AdaptedHeight(28));
    }
    return _titleLab;
}

- (UILabel *)alertLab {
    if (!_alertLab){
        _alertLab = [UILabel createLabelTextColor:RedColor font:kFont_12];
        _alertLab.frame =CGRectMake(AdaptedWidth(60), 0, MainWidth-AdaptedWidth(100), AdaptedHeight(28));
    }
    return _alertLab;
}

@end
