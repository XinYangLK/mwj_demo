//
//  KLOrderApplyForARefundCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLOrderApplyForARefundCell.h"

@implementation KLOrderApplyForARefundCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self goodsImg];
        [self goodsNameLab];
        [self specLab];
    }
    return self;
}

- (void)setGoodsName:(NSString *)goodsName {
    _goodsName =goodsName;
    self.goodsNameLab.text = goodsName;
    CGSize size =[self.goodsNameLab getLableRectWithMaxWidth:MainWidth-AdaptedWidth(118)];
    [self.goodsNameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsImg.mas_right).offset =AdaptedWidth(20);
        make.right.offset =AdaptedWidth(-12);
        make.top.mas_equalTo(self.goodsImg.mas_top).offset =AdaptedHeight(5);
        make.height.offset = size.height;
    }];
}



- (UIImageView *)goodsImg {
    if (!_goodsImg){
        _goodsImg = [UIImageView zj_imageViewWithImage:@"pic_6"
                                             SuperView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.offset    = AdaptedWidth(12);
                                               make.width.offset   = AdaptedWidth(74);
                                               make.height.offset  = AdaptedHeight(74);
                                               make.centerY.offset = 0;
                                           }];
        _goodsImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodsImg;
}

- (UILabel *)goodsNameLab {
    if (!_goodsNameLab){
        _goodsNameLab = [UILabel zj_labelWithFontSize:14
                                            textColor:RGBSigle(51)
                                            superView:self.contentView
                                          constraints:^(MASConstraintMaker *make) {
                                              make.left.mas_equalTo(self.goodsImg.mas_right).offset =AdaptedWidth(20);
                                              make.right.offset =AdaptedWidth(-12);
                                              make.top.mas_equalTo(self.goodsImg.mas_top).offset =AdaptedHeight(5);
                                              make.height.offset =AdaptedHeight(15);
                                          }];
        _goodsNameLab.numberOfLines = 2;
    }
    return _goodsNameLab;
}

- (UILabel *)specLab {
    if (!_specLab){
        _specLab = [UILabel zj_labelWithFontSize:10
                                       textColor:TextColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.height.right.left.mas_equalTo(self.goodsNameLab);
                                         make.bottom.mas_equalTo(self.goodsImg.mas_bottom);
                                     }];
    }
    return _specLab;
}

@end
