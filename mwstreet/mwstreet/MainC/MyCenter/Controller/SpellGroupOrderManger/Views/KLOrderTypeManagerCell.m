//
//  KLOrderTypeManagerCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/15.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLOrderTypeManagerCell.h"
@interface KLOrderTypeManagerCell ()
//***  商品图片  **/
@property (nonatomic, strong) UIImageView * goodsImgView;
//***  商品b名称  **/
@property (nonatomic, strong) UILabel     * goodsTitleLab;
//***  商品价格  **/
@property (nonatomic, strong) UILabel     * goodsPriceLab;
//***  商品描述  **/
@property (nonatomic, strong) UILabel     * goodsDesLab;
//***  订单状态  **/
@property (nonatomic, strong) UILabel     * goodsStatusLab;

@end

@implementation KLOrderTypeManagerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configerUI];
    }
    return self;
}



- (void)setGoodsImg:(NSString *)goodsImg {
    _goodsImg =goodsImg;
    self.goodsImgView.image =[UIImage imageNamed:_goodsImg];
}
- (void)setGoodsTitle:(NSString *)goodsTitle {
    _goodsTitle =goodsTitle;
    self.goodsTitleLab.text = _goodsTitle;
    CGSize size =[self.goodsTitleLab getLableRectWithMaxWidth:MainWidth -AdaptedWidth(160)];
    [self.goodsTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(130);
        make.right.offset =AdaptedWidth(-30);
        make.height.offset =size.height;
        make.top.offset =AdaptedHeight(20);
    }];
}
- (void)setGoodsPrice:(NSString *)goodsPrice {
    _goodsPrice = goodsPrice;
    self.goodsPriceLab.text = _goodsPrice;
}
- (void)setGoodsDes:(NSString *)goodsDes {
    _goodsDes = goodsDes;
    self.goodsDesLab.text = _goodsDes;
}
- (void)setGoodsStatus:(NSString *)goodsStatus {
    _goodsStatus = goodsStatus;
    if ([_goodsStatus isEqualToString:@"拼团成功"] || [_goodsStatus isEqualToString:@"拼团中"]) {
        self.goodsStatusLab.textColor =RedColor;
    }else{
        self.goodsStatusLab.textColor =TextColor;
    }
    self.goodsStatusLab.text = _goodsStatus;
}




#pragma mark - lazy -- UI
- (void)configerUI{
    [self goodsImgView];
    [self goodsTitleLab];
    [self goodsStatusLab];
    [self goodsPriceLab];
    [self goodsDesLab];
}

- (UIImageView *)goodsImgView {
    if (!_goodsImgView){
        _goodsImgView = [UIImageView zj_imageViewWithImage:nil
                                                 SuperView:self.contentView
                                               contentMode:UIViewContentModeScaleAspectFit
                                                    isClip:NO
                                               constraints:^(MASConstraintMaker *make) {
                                                   make.left.offset =AdaptedWidth(10);
                                                   make.top.offset =AdaptedHeight(7);
                                                   make.bottom.offset =AdaptedHeight(-15);
                                                   make.width.offset =AdaptedWidth(85);
                                               }];
    }
    return _goodsImgView;
}

- (UILabel *)goodsTitleLab {
    if (!_goodsTitleLab){
        _goodsTitleLab = [UILabel zj_labelWithFontSize:12
                                                 lines:2
                                                  text:self.goodsTitle
                                             textColor:TitleColor
                                             superView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.offset =AdaptedWidth(130);
                                               make.top.offset =AdaptedHeight(20);
                                               make.right.offset =AdaptedWidth(-30);
                                               make.height.offset =AdaptedHeight(15);
                                           }];
        _goodsTitleLab.lineSpace = 4;
    }
    return _goodsTitleLab;
}


- (UILabel *)goodsPriceLab {
    if (!_goodsPriceLab){
        _goodsPriceLab = [UILabel zj_labelWithFontSize:15
                                             textColor:RedColor
                                             superView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.offset =AdaptedWidth(130);
                                               make.height.offset =AdaptedHeight(15);
                                               make.bottom.offset =AdaptedHeight(-34);
                                               make.right.mas_equalTo(self.goodsStatusLab.mas_left).offset = AdaptedWidth(-10);
                                           }];
    }
    return _goodsPriceLab;
}

- (UILabel *)goodsDesLab {
    if (!_goodsDesLab){
        _goodsDesLab = [UILabel zj_labelWithFontSize:10
                                           textColor:TextColor
                                           superView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.left.offset =AdaptedWidth(130);
                                             make.height.offset =AdaptedHeight(15);
                                             make.bottom.offset =AdaptedHeight(-15);
                                             make.right.mas_equalTo(self.goodsPriceLab);
                                         }];
    }
    return _goodsDesLab;
}

- (UILabel *)goodsStatusLab {
    if (!_goodsStatusLab){
        _goodsStatusLab = [UILabel zj_labelWithFontSize:12
                                                   text:self.goodsStatus
                                              superView:self.contentView
                                            constraints:^(MASConstraintMaker *make) {
                                                make.right.offset =AdaptedWidth(-20);
                                                make.height.offset =AdaptedHeight(15);
                                                make.bottom.offset =AdaptedHeight(-21);
                                                make.width.offset =AdaptedWidth(60);
                                            }];
        _goodsStatusLab.textAlignment =NSTextAlignmentRight;
    }
    return _goodsStatusLab;
}




@end
