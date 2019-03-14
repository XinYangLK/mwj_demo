//
//  KLHeaderButton.m
//  mwstreet
//
//  Created by 科pro on 2018/12/28.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLHeaderButton.h"

@implementation KLHeaderButton

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configerUI];
    }
    return self;
}
#pragma mark ------ 构建UI
- (void)configerUI {
    [self addSubview:self.numLab];
    [self addSubview:self.textLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset =0;
        make.height.offset =AdaptedHeight(15);
    }];
    [self.textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset =0;
        make.height.mas_equalTo(self.numLab);
    }];
}

- (UILabel *)numLab {
    if (!_numLab){
        _numLab = [UILabel createLabelTextColor:RedColor font:kFont_14];
        _numLab.textAlignment =NSTextAlignmentCenter;
    }
    return _numLab;
}

- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel createLabelTextColor:RGBSigle(54) font:kFont_14];
        _textLab.textAlignment =NSTextAlignmentCenter;
    }
    return _textLab;
}

@end
