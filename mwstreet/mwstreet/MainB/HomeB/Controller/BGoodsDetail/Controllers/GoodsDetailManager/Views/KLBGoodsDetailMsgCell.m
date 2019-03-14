//
//  KLBGoodsDetailMsgCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/27.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBGoodsDetailMsgCell.h"

@implementation KLBGoodsDetailMsgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self goodsTitleLab];
    [self goodsPriceLab];
    [self goodsDecLab];
}

- (void)setGoodsTitle:(NSString *)goodsTitle {
    
    _goodsTitle = goodsTitle;
    self.goodsTitleLab.text = goodsTitle;
    CGSize size =[self.goodsTitleLab getLableRectWithMaxWidth:MainWidth-AdaptedWidth(24)];
    [self.goodsTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset  = AdaptedWidth(12);
        make.right.offset = AdaptedWidth(-12);
        make.top.offset   = AdaptedHeight(15);
        make.height.offset= size.height;
    }];
}

- (UILabel *)goodsTitleLab{
    if (!_goodsTitleLab){
        _goodsTitleLab = [UILabel zj_labelWithFontSize:14
                                                 lines:2
                                                  text:nil
                                             textColor:RGBSigle(51)
                                             superView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.offset  = AdaptedWidth(12);
                                               make.right.offset = AdaptedWidth(-12);
                                               make.top.offset   = AdaptedHeight(15);
                                               make.height.offset= AdaptedHeight(15);
                                             }];
    }
    return _goodsTitleLab;
}

- (UILabel *)goodsPriceLab {
    if (!_goodsPriceLab){
        _goodsPriceLab = [UILabel zj_labelWithFontSize:18
                                                 lines:1
                                                  text:nil
                                             textColor:RedColor
                                             superView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.offset   = AdaptedWidth(12);
                                               make.right.offset  = AdaptedWidth(-150);
                                               make.bottom.offset = AdaptedHeight(-16);
                                               make.height.offset = AdaptedHeight(20);
                                           }];
    }
    return _goodsPriceLab;
}


- (UILabel *)goodsDecLab {
    if (!_goodsDecLab){
        _goodsDecLab = [UILabel zj_labelWithFontSize:12
                                                 lines:1
                                                  text:nil
                                             textColor:TextColor
                                             superView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.width.offset   = AdaptedWidth(130);
                                               make.right.offset  = AdaptedWidth(-12);
                                               make.bottom.offset = AdaptedHeight(-16);
                                               make.height.offset = AdaptedHeight(20);
                                           }];
        _goodsDecLab.textAlignment = NSTextAlignmentRight;
    }
    return _goodsDecLab;
}





@end
