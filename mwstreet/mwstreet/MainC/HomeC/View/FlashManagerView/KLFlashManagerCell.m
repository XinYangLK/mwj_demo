//
//  KLFlashManagerCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/28.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLFlashManagerCell.h"


@interface KLFlashManagerCell ()
//***  商品图片  **/
@property (nonatomic, strong) UIImageView * goodsImgV;
//***  商品名称  **/
@property (nonatomic, strong) UILabel     * goodsTitleLab;
//***  商品价格  **/
@property (nonatomic, strong) UILabel     * goodsNewPriceLab;
//***  商品原价格  **/
@property (nonatomic, strong) UILabel     * goodsOldPriceLab;
//***  商品原价格删除线  **/
@property (nonatomic, strong) UIView      * line;
//***  商品限量  **/
@property (nonatomic, strong) UILabel     * goodsLimitedLab;
//***  商品抢购按钮  **/
@property (nonatomic, strong) UIButton    * goodsFlashBtn;
@end

@implementation KLFlashManagerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configerUI];
    }
    return self;
}

#pragma mark - lazy UI
- (void)configerUI {
    [self goodsImgV];
    [self goodsTitleLab];
    [self goodsNewPriceLab];
    [self goodsOldPriceLab];
    [self goodsLimitedLab];
    [self goodsFlashBtn];
    [self line];
}

- (void)setGoodsImg:(NSString *)goodsImg {
    _goodsImg = goodsImg;
    self.goodsImgV.image =[UIImage imageNamed:goodsImg];
}

- (void)setGoodsTitle:(NSString *)goodsTitle {
    _goodsTitle =goodsTitle;
    self.goodsTitleLab.text = [NSString getBlankString:goodsTitle];
    CGSize size = [self.goodsTitleLab getLableRectWithMaxWidth:MainWidth -AdaptedHeight(197)];
    [self.goodsTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsImgV.mas_right).offset =AdaptedWidth(35);
        make.right.offset =AdaptedWidth(27);
        make.height.offset = size.height;
        make.top.offset =AdaptedHeight(19);
    }];
}

- (void)setGoodsPrice:(NSString *)goodsPrice {
     _goodsPrice =goodsPrice;
    self.goodsNewPriceLab.text = [NSString stringWithFormat:@"￥%@",goodsPrice];
}

- (void)setGoodsOldPrice:(NSString *)goodsOldPrice {
    _goodsOldPrice = goodsOldPrice;
    self.goodsOldPriceLab.text = [NSString stringWithFormat:@"￥%@",goodsOldPrice];
    CGFloat width  =[UILabel getWidthWithTitle:self.goodsOldPriceLab.text font:self.goodsOldPriceLab.font];
   
    [self.goodsOldPriceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsNewPriceLab.mas_left).offset =AdaptedWidth(7);
        make.bottom.offset =AdaptedHeight(-28);
        make.height.mas_equalTo(self.goodsNewPriceLab);
        make.width.offset =width;
    }];
    
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.offset = 0.5;
        make.centerX.centerY.mas_equalTo(self.goodsOldPriceLab);
        make.width.offset = width+AdaptedWidth(10);
    }];
}


- (void)setGoodsLimited:(NSString *)goodsLimited {
     _goodsLimited = goodsLimited;
    self.goodsLimitedLab.text = goodsLimited;
}


- (void)setGoodsFlash:(NSString *)goodsFlash {
    _goodsFlash = goodsFlash;
    [self.goodsFlashBtn setTitle:goodsFlash forState:UIControlStateNormal] ;
}









- (UIImageView *)goodsImgV {
    if (!_goodsImgV){
        _goodsImgV = [UIImageView zj_imageViewWithImage:self.goodsImg
                                              SuperView:self.contentView
                                            constraints:^(MASConstraintMaker *make) {
                                                make.left.offset = AdaptedWidth(14);
                                                make.top.offset = AdaptedHeight(11);
                                                make.width.offset =AdaptedWidth(111);
                                                make.height.offset =AdaptedHeight(111);
                                            }];
    }
    return _goodsImgV;
}

- (UILabel *)goodsTitleLab {
    if (!_goodsTitleLab){
        _goodsTitleLab = [UILabel zj_labelWithFontSize:14
                                                 lines:2
                                                  text:self.goodsTitle
                                             textColor:RGBSigle(51)
                                             superView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.mas_equalTo(self.goodsImgV.mas_right).offset =AdaptedWidth(35);
                                               make.right.offset =AdaptedWidth(27);
                                               make.height.offset =AdaptedHeight(15);
                                               make.top.offset =AdaptedHeight(19);
                                           }];
        _goodsTitleLab.lineSpace =4;
    }
    return _goodsTitleLab;
}


- (UILabel *)goodsNewPriceLab {
    if (!_goodsNewPriceLab){
        _goodsNewPriceLab = [UILabel zj_labelWithFont:AdaptedBOLDSYSFontSize(15)
                                                lines:0
                                                 text:self.goodsPrice
                                            textColor:RedColor
                                            superView:self.contentView
                                          constraints:^(MASConstraintMaker *make) {
                                              make.left.mas_equalTo(self.goodsTitleLab.mas_left).offset =AdaptedWidth(7);
                                              make.bottom.offset =AdaptedHeight(-54);
                                              make.height.offset =AdaptedHeight(15);
                                              make.right.offset =AdaptedWidth(-100);
                                          }];
    }
    return _goodsNewPriceLab;
}

- (UILabel *)goodsOldPriceLab {
    if (!_goodsOldPriceLab){
        _goodsOldPriceLab = [UILabel zj_labelWithFontSize:12
                                                    lines:0
                                                     text:self.goodsOldPrice
                                                textColor:TextColor
                                                superView:self.contentView
                                              constraints:^(MASConstraintMaker *make) {
                                                  make.left.mas_equalTo(self.goodsNewPriceLab.mas_left).offset =AdaptedWidth(7);
                                                  make.bottom.offset =AdaptedHeight(-28);
                                                  make.right.height.mas_equalTo(self.goodsNewPriceLab);
                                              }];
    }
    return _goodsOldPriceLab;
}

- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:TextColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.height.offset = 0.5;
                                     make.centerX.centerY.mas_equalTo(self.goodsOldPriceLab);
                                     make.width.offset =AdaptedWidth(60);
                                 }];
    }
    return _line;
}


- (UIButton *)goodsFlashBtn {
    if (!_goodsFlashBtn){
        _goodsFlashBtn = [UIButton zj_buttonWithTitle:self.goodsFlash
                                           titleColor:[UIColor whiteColor]
                                            backColor:RedColor
                                             fontSize:14
                                               isBold:NO
                                         cornerRadius:AdaptedHeight(14)
                                              supView:self.contentView
                                          constraints:^(MASConstraintMaker *make) {
                                              make.right.offset =AdaptedWidth(-10);
                                              make.width.offset =AdaptedWidth(88);
                                              make.height.offset =AdaptedHeight(28);
                                              make.bottom.offset =AdaptedHeight(-25);
                                          } touchUp:^(id sender) {
                                              
                                          }];
    }
    return _goodsFlashBtn;
}


- (UILabel *)goodsLimitedLab {
    if (!_goodsLimitedLab){
        _goodsLimitedLab = [UILabel zj_labelWithFontSize:12
                                                   lines:0
                                                    text:self.goodsLimited
                                               textColor:TextColor
                                               superView:self.contentView
                                             constraints:^(MASConstraintMaker *make) {
                                                 make.centerX.mas_equalTo(self.goodsFlashBtn);
                                                 make.bottom.mas_equalTo(self.goodsFlashBtn.mas_top).offset =AdaptedHeight(-11);
                                                 make.height.offset =AdaptedHeight(15);
                                                 make.width.mas_equalTo(self.goodsFlashBtn);
                                             }];
        _goodsLimitedLab.textAlignment = NSTextAlignmentCenter;
    }
    return _goodsLimitedLab;
}


@end
