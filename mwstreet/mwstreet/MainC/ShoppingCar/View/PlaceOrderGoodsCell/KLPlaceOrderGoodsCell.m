//
//  KLPlaceOrderGoodsCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/16.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLPlaceOrderGoodsCell.h"

@interface KLPlaceOrderGoodsCell ()

@property (nonatomic, strong) UIImageView * goodsImg;
@property (nonatomic, strong) UILabel     * titleLab;
@property (nonatomic, strong) UILabel     * specLab;
@property (nonatomic, strong) UILabel     * priceLab;
@property (nonatomic, strong) UILabel     * numberLab;

@end

@implementation KLPlaceOrderGoodsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configerUI];
    }
    return self;
}


- (void)setImgName:(NSString *)imgName {
    _imgName = imgName;
    self.goodsImg.image =[UIImage imageNamed:_imgName];
}

- (void)setGoodsName:(NSString *)goodsName {
    _goodsName = goodsName;
    self.titleLab.text = _goodsName;
    CGSize size =[self.titleLab getLableRectWithMaxWidth:MainWidth-AdaptedWidth(207)];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset   = AdaptedWidth(103);
        make.right.offset  = AdaptedWidth(-104);
        make.height.offset = size.height;
        make.top.offset    = AdaptedHeight(15);
    }];
}

- (void)setGoodsPrice:(NSString *)goodsPrice {
    _goodsPrice = goodsPrice;
    self.priceLab.text = _goodsPrice;
}

- (void)setGoodsNumber:(NSString *)goodsNumber {
    _goodsNumber =goodsNumber;
    self.numberLab.text = _goodsNumber;
}




#pragma mark - lazy UI
- (void)configerUI {
    [self goodsImg];
    [self titleLab];
    [self specLab];
    [self priceLab];
    [self numberLab];
}

- (UIImageView *)goodsImg {
    if (!_goodsImg){
        _goodsImg = [UIImageView zj_imageViewWithImage:nil
                                             SuperView:self.contentView
                                           contentMode:UIViewContentModeScaleAspectFit
                                                isClip:NO
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.offset =AdaptedWidth(10);
                                               make.top.offset =AdaptedHeight(8);
                                               make.height.offset =AdaptedHeight(74);
                                               make.width.offset =AdaptedWidth(74);
                                           }];
    }
    return _goodsImg;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:2
                                             text:nil
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.mas_equalTo(self.goodsImg.mas_right).offset =AdaptedWidth(20);
                                          make.right.offset =AdaptedWidth(-104);
                                          make.height.offset =AdaptedHeight(15);
                                          make.top.offset =AdaptedHeight(15);
                                      }];
        _titleLab.lineSpace = 4;
    }
    return _titleLab;
}

- (UILabel *)specLab {
    if (!_specLab){
        _specLab = [UILabel zj_labelWithFontSize:10
                                           lines:0
                                            text:@"规格：15Kg"
                                       textColor:TextColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.mas_equalTo(self.titleLab);
                                         make.right.offset = AdaptedWidth(-104);
                                         make.bottom.mas_equalTo(self.goodsImg.mas_bottom);
                                         make.height.offset =AdaptedHeight(15);
                                     }];
    }
    return _specLab;
}


- (UILabel *)priceLab {
    if (!_priceLab){
        _priceLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:nil
                                        textColor:TextColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(10);
                                          make.right.offset =AdaptedWidth(-12);
                                          make.height.offset =AdaptedHeight(15);
                                          make.top.offset =AdaptedHeight(15);
                                      }];
        _priceLab.textAlignment = NSTextAlignmentRight;
    }
    return _priceLab;
}



- (UILabel *)numberLab {
    if (!_numberLab){
        _numberLab = [UILabel zj_labelWithFontSize:14
                                             lines:1
                                              text:nil
                                         textColor:TextColor
                                         superView:self.contentView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.left.mas_equalTo(self.priceLab);
                                           make.right.offset =AdaptedWidth(-12);
                                           make.height.offset =AdaptedHeight(15);
                                           make.bottom.offset =AdaptedHeight(-12);
                                       }];
        _numberLab.textAlignment = NSTextAlignmentRight;
    }
    return _numberLab;
}


@end
