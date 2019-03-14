//
//  KLGoodsButton.m
//  mwstreet
//
//  Created by 科pro on 2018/12/21.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLGoodsButton.h"

@interface KLGoodsButton ()
@property (nonatomic, strong) UIImageView * borderImg;   //边框
@property (nonatomic, strong) UIImageView * goodsImgV;    //商品图片
@property (nonatomic, strong) UILabel     * priceLab;    //商品价格
@property (nonatomic, strong) UILabel     * oldPriceLab; //商品原价
@property (nonatomic, strong) UIView      * line;        //删除线

@end

@implementation KLGoodsButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)setGoodsPrice:(NSString *)goodsPrice {
    _goodsPrice = goodsPrice;
    self.priceLab.text = [NSString getBlankString:_goodsPrice];
}
- (void)setGoodsImg:(NSString *)goodsImg{
    _goodsImg = goodsImg;
    if (_goodsImg) {
        self.goodsImgV.image =[UIImage imageNamed:_goodsImg];
    }
}
- (void)setGoodsOldPrice:(NSString *)goodsOldPrice{
    _goodsOldPrice = goodsOldPrice;
    self.oldPriceLab.text =[NSString getBlankString:_goodsOldPrice];
    CGFloat width =[UILabel getWidthWithTitle:self.oldPriceLab.text font:self.oldPriceLab.font];
    [self.oldPriceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset = AdaptedHeight(-8);
        make.centerX.height.mas_equalTo(self.priceLab);
        make.width.offset = width;
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.oldPriceLab);
        make.width.offset =width + AdaptedWidth(5);
        make.height.offset =0.5;
    }];
}



- (void)configUI {
    [self addSubview:self.borderImg];
    [self addSubview:self.goodsImgV];
    [self addSubview:self.priceLab];
    [self addSubview:self.oldPriceLab];
    [self addSubview:self.line];

    [self.borderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    [self.goodsImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(15);
        make.right.offset =AdaptedWidth(-15);
        make.top.offset = AdaptedHeight(10);
        make.height.offset =AdaptedHeight(90);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset =0;
        make.height.offset =AdaptedHeight(15);
        make.top.mas_equalTo(self.goodsImgV.mas_bottom).offset =AdaptedHeight(8);
        make.width.offset =AdaptedWidth(90);
    }];
   
}


- (UIImageView *)borderImg {
    if (!_borderImg){
        _borderImg = [[UIImageView alloc]init];
        _borderImg.image =[UIImage imageNamed:@"bk_2"];
    }
    return _borderImg;
}


- (UIImageView *)goodsImgV {
    if (!_goodsImgV){
        _goodsImgV = [[UIImageView alloc]init];
        _goodsImgV.contentMode =UIViewContentModeScaleAspectFit;

    }
    return _goodsImgV;
}

- (UILabel *)priceLab {
    if (!_priceLab){
        _priceLab =[UILabel createLabelTextColor:RedColor font:kFont_15];
        _priceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLab;
}

- (UILabel *)oldPriceLab {
    if (!_oldPriceLab){
        _oldPriceLab =[UILabel createLabelTextColor:RGBSigle(183) font:kFont_12];
        _oldPriceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _oldPriceLab;
}

- (UIView *)line {
    if (!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor =RGBSigle(183);
    }
    return _line;
}


@end
