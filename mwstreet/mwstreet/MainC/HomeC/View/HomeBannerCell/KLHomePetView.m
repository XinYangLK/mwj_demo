//
//  KLHomePetView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/8.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLHomePetView.h"

@implementation KLHomePetView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    [self addSubview:self.backImg];
    [self addSubview:self.petImg];
    [self addSubview:self.nickNameLab];
    [self addSubview:self.nameLab];
    [self addSubview:self.ageLab];
    
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.petImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(25);
        make.width.height.offset =AdaptedHeight(33);
        make.centerY.offset =AdaptedHeight(-8);
    }];
    [self.nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.petImg.mas_right).offset =AdaptedWidth(15);
        make.centerY.mas_equalTo(self.petImg);
        make.width.offset = AdaptedWidth(90);
        make.height.offset =AdaptedHeight(15);
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickNameLab.mas_right).offset =AdaptedWidth(10);
        make.right.offset =AdaptedWidth(-55);
        make.height.mas_equalTo(self.nickNameLab);
        make.centerY.mas_equalTo(self.petImg);
    }];
    [self.ageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab.mas_right).offset =AdaptedWidth(5);
        make.right.offset =AdaptedWidth(-25);
        make.height.mas_equalTo(self.nickNameLab);
        make.centerY.mas_equalTo(self.petImg);
    }];
}

- (UIImageView *)backImg {
    if (!_backImg){
        _backImg = [[UIImageView alloc]init];
        _backImg.image = [UIImage imageNamed:@"bk_1"];
    }
    return _backImg;
}

- (UIImageView *)petImg {
    if (!_petImg){
        _petImg = [[UIImageView alloc]init];
        [_petImg setLayerCornerRadius:AdaptedHeight(16.5)];
    }
    return _petImg;
}
- (UILabel *)nickNameLab {
    if (!_nickNameLab){
        _nickNameLab = [UILabel createLabelTextColor:TitleColor font:kFont_12];
    }
    return _nickNameLab;
}

- (UILabel *)nameLab {
    if (!_nameLab){
        _nameLab = [UILabel createLabelTextColor:TitleColor font:kFont_10];
        _nameLab.textAlignment =NSTextAlignmentCenter;
    }
    return _nameLab;
}

- (UILabel *)ageLab {
    if (!_ageLab){
        _ageLab = [UILabel createLabelTextColor:TitleColor font:kFont_10];
        _ageLab.textAlignment =NSTextAlignmentRight;
    }
    return _ageLab;
}


@end
