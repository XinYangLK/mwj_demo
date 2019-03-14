//
//  KLShoppingCarBottomView.m
//  mwstreet
//
//  Created by 科pro on 2018/12/29.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLShoppingCarBottomView.h"

@implementation KLShoppingCarBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        [self configerUI];
    }
    return self;
}
#pragma mark ------ 构建 UI
- (void)configerUI {
    [self addSubview:self.line];
    [self addSubview:self.selectImgBtn];
    [self addSubview:self.totalPriceLab];
    [self addSubview:self.actionBtn];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset =0;
        make.height.offset =0.5;
    }];
    
    [self.selectImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(15);
        make.height.width.offset =AdaptedHeight(20);
        make.centerY.offset =0;
    }];
    [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset =0;
        make.height.offset =AdaptedHeight(33);
        make.right.offset =AdaptedWidth(-5);
        make.width.offset =AdaptedWidth(95);
    }];
    [self.totalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectImgBtn.mas_right).offset =AdaptedWidth(25);
        make.centerY.height.mas_equalTo(self.selectImgBtn);
        make.right.mas_equalTo(self.actionBtn.mas_left).offset =AdaptedWidth(-30);
    }];
}

- (UIView *)line {
    if (!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor =COLOR(@"#DCDCDC");
    }
    return _line;
}

- (UIButton *)selectImgBtn {
    if (!_selectImgBtn){
        _selectImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectImgBtn setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
    }
    return _selectImgBtn;
}

- (UIButton *)actionBtn {
    if (!_actionBtn){
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionBtn setLayerCornerRadius:AdaptedHeight(16)];
        [_actionBtn setBackgroundImage:[UIImage imageWithColor:RedColor] forState:UIControlStateNormal];
        _actionBtn.titleLabel.font =kFont_15;
        [_actionBtn setTitle:@"结算" forState:UIControlStateNormal];
        [_actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _actionBtn;
}

- (UILabel *)totalPriceLab {
    if (!_totalPriceLab){
        _totalPriceLab = [UILabel createLabelTextColor:TitleColor font:kFont_15];
        _totalPriceLab.text =@"合计：0.00";
    }
    return _totalPriceLab;
}


@end
