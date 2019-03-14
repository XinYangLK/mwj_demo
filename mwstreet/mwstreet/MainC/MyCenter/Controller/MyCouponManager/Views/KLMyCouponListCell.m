//
//  KLMyCouponListCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/11.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyCouponListCell.h"

@implementation KLMyCouponListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    [self.contentView addSubview:self.bigImgView];
    [self.bigImgView addSubview:self.priceLab];
    [self.bigImgView addSubview:self.limitLab];
    [self.contentView addSubview:self.smallImgView];
    [self.smallImgView addSubview:self.totalLab];
    [self.smallImgView addSubview:self.useCouponBtn];
    [self.smallImgView addSubview:self.timeLab];

    [self.bigImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset    = AdaptedWidth(10);
        make.centerY.offset = 0;
        make.height.offset  = AdaptedHeight(90);
        make.width.offset   = MainWidth/2 +AdaptedWidth(20);
    }];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.offset     = AdaptedHeight(14);
        make.height.offset  = AdaptedHeight(40);
        make.width.offset   = MainWidth/2 ;
    }];
    [self.limitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.bottom.offset  = AdaptedWidth(-12);
        make.width.offset   = MainWidth/2;
        make.height.offset  = AdaptedHeight(15);
    }];
    [self.smallImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bigImgView.mas_right);
        make.right.offset =AdaptedWidth(-10);
        make.height.centerY.mas_equalTo(self.bigImgView);
    }];
    [self.totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset     = AdaptedHeight(15);
        make.height.offset  = AdaptedHeight(15);
        make.width.offset   = MainWidth/2 -AdaptedWidth(70);
        make.centerX.offset = 0;
    }];
    [self.useCouponBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset = 0;
        make.height.offset          = AdaptedHeight(21);
        make.width.offset           = AdaptedWidth(76);
    }];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.useCouponBtn.mas_bottom).offset = AdaptedHeight(8);
        make.height.offset  = AdaptedHeight(15);
        make.centerX.offset = 0;
        make.width.offset   = MainWidth/2 -AdaptedWidth(70);
    }];
}

- (UIImageView *)bigImgView {
    if (!_bigImgView){
        _bigImgView = [[UIImageView alloc]init];
        _bigImgView.image =[UIImage imageNamed:@"bnrtg_b"];
    }
    return _bigImgView;
}


- (UILabel *)priceLab {
    if (!_priceLab){
        _priceLab = [[UILabel alloc]init];
        _priceLab.textColor = [UIColor whiteColor];
        _priceLab.font = AdaptedBOLDSYSFontSize(50);
        _priceLab.textAlignment =NSTextAlignmentCenter;
    }
    return _priceLab;
}

- (UILabel *)limitLab {
    if (!_limitLab){
        _limitLab = [UILabel createLabelTextColor:RGBSigle(255) font:AdaptedSYSFontSize(9)];
        _limitLab.textAlignment =NSTextAlignmentCenter;
    }
    return _limitLab;
}


- (UIImageView *)smallImgView {
    if (!_smallImgView){
        _smallImgView = [[UIImageView alloc]init];
        _smallImgView.image =[UIImage imageNamed:@"egtr_fa"];
        _smallImgView.userInteractionEnabled = YES;
    }
    return _smallImgView;
}

- (UILabel *)totalLab {
    if (!_totalLab){
        _totalLab = [UILabel createLabelTextColor:RGBSigle(255) font:kFont_12];
        _totalLab.textAlignment =NSTextAlignmentCenter;
    }
    return _totalLab;
}
- (UIButton *)useCouponBtn {
    if (!_useCouponBtn){
        _useCouponBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_useCouponBtn setLayerCornerRadius:AdaptedHeight(10.5)];
        [_useCouponBtn setBackgroundImage:[UIImage imageWithColor:RGBSigle(255)] forState:UIControlStateNormal];
        [_useCouponBtn setTitleColor:RedColor forState:UIControlStateNormal];
        _useCouponBtn.titleLabel.font = kFont_13;
        [_useCouponBtn addTarget:self action:@selector(useCouponChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _useCouponBtn;
}

- (UILabel *)timeLab {
    if (!_timeLab){
        _timeLab = [UILabel createLabelTextColor:RGBSigle(255) font:AdaptedSYSFontSize(9)];
        _timeLab.textAlignment =NSTextAlignmentCenter;
    }
    return _timeLab;
}

#pragma mark - 立即使用回调
- (void)useCouponChick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"已领取"]) {
        return;
    }
    self.useCouponBlock ? self.useCouponBlock(sender, self.indexPath) : nil;
}



@end
