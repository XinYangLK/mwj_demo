//
//  KLGoodsDetailBottomView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/10.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLGoodsDetailBottomView.h"

@implementation KLGoodsDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    [self addSubview:self.serviceBtn];
    [self addSubview:self.line];
    [self addSubview:self.collectBtn];
    [self addSubview:self.addShopCarBtn];
    [self addSubview:self.placeOrderBtn];
    
    [self.serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =0;
        make.top.offset =0;
        make.bottom.offset = - TabbarSafeBottomMargin;
        make.width.offset = AdaptedWidth(70);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.serviceBtn.mas_right).offset =0;
        make.width.offset =1;
        make.top.bottom.mas_equalTo(self.serviceBtn);
    }];

    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line.mas_right).offset =0;
        make.width.top.bottom.mas_equalTo(self.serviceBtn);
    }];
    [self.addShopCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.collectBtn.mas_right).offset =0;
        make.top.bottom.mas_equalTo(self.serviceBtn);
        make.width.offset =(MainWidth - AdaptedWidth(130))/2;

    }];
    [self.placeOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addShopCarBtn.mas_right).offset =0;
        make.width.top.bottom.mas_equalTo(self.addShopCarBtn);
    }];


}


- (UIView *)line {
    if (!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor = LineColor;
    }
    return _line;
}

- (UIButton *)serviceBtn {
    if (!_serviceBtn){
        klWeakSelf;
        _serviceBtn = [UIButton createBtnTitle:@"客服" titleColor:RGBSigle(51) font:kFont_14 imageName:@"kefu" backgrounColor:[UIColor whiteColor] SSImagePositionType:SSImagePositionTypeTop spacing:4 action:^(UIButton * _Nonnull button) {
            [weakSelf btnChick:button];
        }];
        _serviceBtn.tag = 200;
    }
    return _serviceBtn;
}

- (UIButton *)collectBtn {
    if (!_collectBtn){
        klWeakSelf;
        _collectBtn = [UIButton createBtnTitle:@"收藏" titleColor:RGBSigle(51) font:kFont_14 imageName:@"shoucang" backgrounColor:[UIColor whiteColor] SSImagePositionType:SSImagePositionTypeTop spacing:4 action:^(UIButton * _Nonnull button) {
            [weakSelf btnChick:button];
        }];
         _collectBtn.tag = 201;
    }
    return _collectBtn;
}

- (UIButton *)addShopCarBtn {
    if (!_addShopCarBtn){
        klWeakSelf;
        _addShopCarBtn = [UIButton createBtnTitle:@"加入购物车" titleColor:[UIColor whiteColor] font:kFont_14 imageName:@"" backgrounColor:MainColor action:^(UIButton * _Nonnull button) {
             [weakSelf btnChick:button];
        }];
        _addShopCarBtn.tag = 202;
    }
    return _addShopCarBtn;
}

- (UIButton *)placeOrderBtn {
    if (!_placeOrderBtn){
        klWeakSelf;
        _placeOrderBtn = [UIButton createBtnTitle:@"立即购买" titleColor:[UIColor whiteColor] font:kFont_14 imageName:@"" backgrounColor:RedColor action:^(UIButton * _Nonnull button) {
             [weakSelf btnChick:button];
        }];
        _placeOrderBtn.tag = 203;
    }
    return _placeOrderBtn;
}


//***  点击响应  **/
- (void)btnChick:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didActionBtnChick:)]) {
        [self.delegate didActionBtnChick:sender];
    }
}


@end
