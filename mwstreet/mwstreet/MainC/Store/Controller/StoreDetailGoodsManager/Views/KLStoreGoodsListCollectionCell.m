//
//  KLStoreGoodsListCollectionCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/30.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreGoodsListCollectionCell.h"

@interface KLStoreGoodsListCollectionCell ()

//***  商品图片  **/
@property (nonatomic, strong) UIImageView *imageV;
//***  商品名称  **/
@property (nonatomic, strong) UILabel * goodsNameLab;
//***  商品描述  **/
@property (nonatomic, strong) UILabel * goodsDesLab;
//***  商品价格  **/
@property (nonatomic, strong) UILabel * goodsPriceLab;

@end

@implementation KLStoreGoodsListCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        
        [self confingerUI];
    }
    return self;
}

- (void)confingerUI {
    [self imageV];
    [self goodsNameLab];
    [self goodsDesLab];
    [self goodsPriceLab];
}


- (void)setGoodsImg:(NSString *)goodsImg {
    _goodsImg =goodsImg;
    self.imageV.image = [UIImage imageNamed:goodsImg];
}

- (void)setGoodsName:(NSString *)goodsName {
    _goodsName =goodsName;
    self.goodsNameLab.text =goodsName;
}

- (void)setGoodsDes:(NSString *)goodsDes {
     _goodsDes = goodsDes;
    _goodsDesLab.text =goodsDes;
}

- (void)setGoodsPrice:(NSString *)goodsPrice {
    _goodsPrice = goodsPrice;
    _goodsPriceLab.text =[NSString stringWithFormat:@"￥%@",goodsPrice];
}


-(UIImageView *)imageV {
    if (!_imageV){
        _imageV = [UIImageView zj_imageViewWithImage:nil
                                           SuperView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                              make.top.left.right.offset = 0;
                                              make.height.offset =AdaptedHeight(180);
                                         }];
    }
    return _imageV;
}

- (UILabel *)goodsNameLab {
    if (!_goodsNameLab){
        _goodsNameLab = [UILabel zj_labelWithFontSize:14
                                                lines:1
                                                 text:nil
                                            textColor:RGBSigle(51)
                                            superView:self.contentView
                                          constraints:^(MASConstraintMaker *make) {
                                              make.left.right.offset = 0;
                                              make.height.offset =AdaptedHeight(15);
                                              make.top.mas_equalTo(self.imageV.mas_bottom).offset =AdaptedHeight(15);
                                          }];
    }
    return _goodsNameLab;
}

- (UILabel *)goodsDesLab {
    if (!_goodsDesLab){
        _goodsDesLab = [UILabel zj_labelWithFontSize:10
                                               lines:1
                                                text:nil
                                           textColor:TextColor
                                           superView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.top.mas_equalTo(self.goodsNameLab.mas_bottom).offset = AdaptedHeight(10);
                                             make.left.right.offset = 0;
                                             make.height.offset =AdaptedHeight(14);
                                         }];
    }
    return _goodsDesLab;
}



- (UILabel *)goodsPriceLab {
    if (!_goodsPriceLab){
        _goodsPriceLab = [UILabel zj_labelWithFontSize:14
                                                 lines:1
                                                  text:nil
                                             textColor:RedColor
                                             superView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.top.mas_equalTo(self.goodsDesLab.mas_bottom).offset =AdaptedHeight(10);
                                               make.left.right.offset = 0;
                                               make.height.offset =AdaptedHeight(14);
                                           }];
    }
    return _goodsPriceLab;
}


@end






@interface KLStoreGoodsListTableCell ()

//***  商品图片  **/
@property (nonatomic, strong) UIImageView *imageV;
//***  商品名称  **/
@property (nonatomic, strong) UILabel * goodsNameLab;
//***  商品描述  **/
@property (nonatomic, strong) UILabel * goodsDesLab;
//***  商品价格  **/
@property (nonatomic, strong) UILabel * goodsPriceLab;
//***  分割线  **/
@property (nonatomic, strong) UIView  * line;
@end

@implementation KLStoreGoodsListTableCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        
        [self confingerUI];
    }
    return self;
}

- (void)confingerUI {
    [self imageV];
    [self goodsNameLab];
    [self goodsDesLab];
    [self goodsPriceLab];
    [self line];
}


- (void)setGoodsImg:(NSString *)goodsImg {
    _goodsImg =goodsImg;
    self.imageV.image = [UIImage imageNamed:goodsImg];
}

- (void)setGoodsName:(NSString *)goodsName {
    _goodsName =goodsName;
    self.goodsNameLab.text =goodsName;
}

- (void)setGoodsDes:(NSString *)goodsDes {
    _goodsDes = goodsDes;
    _goodsDesLab.text =goodsDes;
}

- (void)setGoodsPrice:(NSString *)goodsPrice {
    _goodsPrice = goodsPrice;
    _goodsPriceLab.text =[NSString stringWithFormat:@"￥%@",goodsPrice];
}


-(UIImageView *)imageV {
    if (!_imageV){
        _imageV = [UIImageView zj_imageViewWithImage:nil
                                           SuperView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.left.offset   = AdaptedWidth(12);
                                             make.top.offset    = AdaptedHeight(20);
                                             make.bottom.offset = AdaptedHeight(-20);
                                             make.width.offset  = AdaptedWidth(110);
                                         }];
    }
    return _imageV;
}

- (UILabel *)goodsNameLab {
    if (!_goodsNameLab){
        _goodsNameLab = [UILabel zj_labelWithFontSize:14
                                                lines:1
                                                 text:nil
                                            textColor:RGBSigle(51)
                                            superView:self.contentView
                                          constraints:^(MASConstraintMaker *make) {
                                              make.left.mas_equalTo(self.imageV.mas_right).offset = AdaptedWidth(20);
                                              make.right.offset = AdaptedWidth(-12);
                                              make.height.offset =AdaptedHeight(15);
                                              make.top.mas_equalTo(self.imageV.mas_top).offset =AdaptedHeight(5);
                                          }];
    }
    return _goodsNameLab;
}

- (UILabel *)goodsDesLab {
    if (!_goodsDesLab){
        _goodsDesLab = [UILabel zj_labelWithFontSize:10
                                               lines:1
                                                text:nil
                                           textColor:TextColor
                                           superView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                            
                                             make.top.mas_equalTo(self.goodsNameLab.mas_bottom).offset = AdaptedHeight(10);
                                             make.height.left.right.mas_equalTo(self.goodsNameLab);
                                         }];
    }
    return _goodsDesLab;
}



- (UILabel *)goodsPriceLab {
    if (!_goodsPriceLab){
        _goodsPriceLab = [UILabel zj_labelWithFontSize:14
                                                 lines:1
                                                  text:nil
                                             textColor:RedColor
                                             superView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.bottom.mas_equalTo(self.imageV.mas_bottom).offset =AdaptedHeight(-5);
                                               make.height.left.right.mas_equalTo(self.goodsNameLab);
                                           }];
    }
    return _goodsPriceLab;
}


- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.right.bottom.offset = 0;
                                     make.height.offset =0.5f;
                                 }];
    }
    return _line;
}


@end
