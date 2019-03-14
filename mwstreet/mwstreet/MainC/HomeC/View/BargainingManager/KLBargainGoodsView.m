//
//  KLBargainGoodsView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBargainGoodsView.h"

@interface KLBargainGoodsView ()

@property (nonatomic, strong) UILabel     * accoutNameLab;
@property (nonatomic, strong) UILabel     * goodsTitleLab;
@property (nonatomic, strong) UILabel     * goodsPriceLab;
@property (nonatomic, strong) UILabel     * describeLab;

@end

@implementation KLBargainGoodsView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
         [self configerUI];
    }
    return self;
}


- (void)setAccoutName:(NSString *)accoutName {
    _accoutName = accoutName;
    self.accoutNameLab.text = [NSString getBlankString:_accoutName];
}

- (void)setGoodsTitle:(NSString *)goodsTitle {
    _goodsTitle =goodsTitle;
    self.goodsTitleLab.text = [NSString getBlankString:_goodsTitle];
    
    CGSize size = [self.goodsTitleLab getLableRectWithMaxWidth:MainWidth-AdaptedWidth(151)];
    [self.goodsTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsImg.mas_right).offset = AdaptedWidth(16);
        make.top.mas_equalTo(self.accoutNameLab.mas_bottom).offset =AdaptedHeight(15);
        make.right.offset =AdaptedWidth(-17);
        make.height.offset = size.height;
    }];
}

- (void)setGoodsPrice:(NSString *)goodsPrice {
    _goodsPrice =goodsPrice;
    self.goodsPriceLab.text = [NSString getBlankString:_goodsPrice];

    self.goodsPriceLab.attributedText =[NSMutableAttributedString getAttributedString:[NSString stringWithFormat:@"还差%@元",self.goodsPriceLab.text] handleString:self.goodsPriceLab.text handleStrFont:kFont_14 handleStrColor:RedColor];
}

- (void)setDescribeStr:(NSString *)describeStr {
    _describeStr =describeStr;
    self.describeLab.text = [NSString getBlankString:_describeStr];
}


#pragma mark - lazy UI
- (void)configerUI {
    
    [self backView];
    [self accoutImg];
    [self accoutNameLab];
    [self goodsImg];
    [self goodsTitleLab];
    [self goodsPriceLab];
    [self describeLab];
}


- (UIView *)backView {
    if (!_backView){
        _backView = [UIView zj_viewWithBackColor:RGBSigle(255)
                                         supView:self
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.offset =AdaptedWidth(16);
                                         make.height.offset = AdaptedHeight(159);
                                         make.centerX.offset =0;
                                         make.top.offset =AdaptedHeight(47);
                                     }];
        _backView.backgroundColor =[UIColor whiteColor];
        [_backView setLayerCornerRadius:5];
    }
    return _backView;
}

- (UIImageView *)accoutImg {
    if (!_accoutImg){
        _accoutImg = [UIImageView zj_imageViewWithImage:@"touxiang"
                                              SuperView:self
                                            constraints:^(MASConstraintMaker *make) {
                                                make.centerX.offset =0;
                                                make.top.offset =AdaptedHeight(23);
                                                make.width.height.offset =AdaptedHeight(52);
                                            }];
        [_accoutImg setLayerCornerRadius:AdaptedHeight(26) borderWidth:1 borderColor:[UIColor whiteColor]];
    }
    return _accoutImg;
}

- (UILabel *)accoutNameLab {
    if (!_accoutNameLab ){
        _accoutNameLab = [UILabel zj_labelWithFontSize:14
                                              lines:1
                                               text:self.accoutName
                                          textColor:RGBSigle(51)
                                          superView:self
                                        constraints:^(MASConstraintMaker *make) {
                                            make.centerX.offset = 0;
                                            make.top.mas_equalTo(self.accoutImg.mas_bottom).offset =AdaptedHeight(8);
                                            make.width.offset =AdaptedWidth(80);
                                            make.height.offset =AdaptedHeight(15);
                                        }];
        _accoutNameLab.textAlignment =NSTextAlignmentCenter;
    }
    return _accoutNameLab;
}

- (UIImageView *)goodsImg {
    if (!_goodsImg){
        _goodsImg = [UIImageView zj_imageViewWithImage:@"pic_6"
                                             SuperView:self.backView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.offset =AdaptedWidth(17);
                                               make.top.offset =AdaptedHeight(32);
                                               make.width.height.offset =AdaptedWidth(69);
                                           }];
    }
    return _goodsImg;
}

- (UILabel *)goodsTitleLab {
    if (!_goodsTitleLab){
        _goodsTitleLab = [UILabel zj_labelWithFontSize:14
                                              lines:2
                                               text:self.goodsTitle
                                          textColor:RGBSigle(51)
                                          superView:self.backView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.left.mas_equalTo(self.goodsImg.mas_right).offset = AdaptedWidth(16);
                                            make.top.mas_equalTo(self.accoutNameLab.mas_bottom).offset =AdaptedHeight(10);
                                            make.right.offset =AdaptedWidth(-17);
                                            make.height.offset =AdaptedHeight(15);
                                        }];
        _goodsTitleLab.lineSpace = 4;
    }
    return _goodsTitleLab;
}

- (UILabel *)goodsPriceLab {
    if (!_goodsPriceLab){
        _goodsPriceLab = [UILabel zj_labelWithFontSize:14
                                                 lines:1
                                                  text:self.goodsPrice
                                             textColor:RGBSigle(51)
                                             superView:self.backView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.bottom.offset =AdaptedHeight(-30);
                                               make.right.left.mas_equalTo(self.goodsTitleLab);
                                               make.height.offset =AdaptedHeight(15);
                                           }];
    }
    return _goodsPriceLab;
}

- (UILabel *)describeLab {
    if (!_describeLab){
        _describeLab = [UILabel zj_labelWithFontSize:10
                                               lines:1
                                                text:self.describeStr
                                           textColor:TextColor
                                           superView:self.backView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.bottom.offset =AdaptedHeight(-10);
                                             make.right.left.mas_equalTo(self.goodsTitleLab);
                                             make.height.offset =AdaptedHeight(15);
                                         }];
    }
    return _describeLab;
}

@end
