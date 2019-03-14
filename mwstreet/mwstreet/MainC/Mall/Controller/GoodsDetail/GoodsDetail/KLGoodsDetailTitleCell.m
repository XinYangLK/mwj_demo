//
//  KLGoodsDetailTitleCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLGoodsDetailTitleCell.h"

@implementation KLGoodsDetailTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configerUI];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = [self.goodsTitle getLableRectWithMaxWidth:MainWidth - AdaptedWidth(105)];
    self.goodsTitle.text = [NSString getBlankString:self.goodsTitle.text];
    [self.goodsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.top.offset =AdaptedHeight(15);
        make.height.offset = size.height;
        make.right.offset =AdaptedWidth(-95);
    }];
    
    NSString *goodsPrice =[NSString getBlankString:self.goodsPrice.text];
    CGFloat priceW =[UILabel getWidthWithTitle:goodsPrice font:self.goodsPrice.font];
    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.bottom.offset =AdaptedHeight(-15);
        make.width.offset = priceW;
        make.height.offset =AdaptedHeight(20);
    }];
    
    
    NSString *oldPrice =[NSString getBlankString:self.oldPrice.text];
    CGFloat oldPriceW =[UILabel getWidthWithTitle:oldPrice font:self.oldPrice.font];
    [self.oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsPrice.mas_right).offset =AdaptedWidth(20);
        make.bottom.offset =AdaptedHeight(-15);
        make.width.offset = oldPriceW;
        make.height.offset =AdaptedHeight(20);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.oldPrice);
        make.width.offset  = oldPriceW + AdaptedWidth(8);
        make.height.offset = 1;
    }];
    
    [self.decLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.line);
        make.right.offset =AdaptedWidth(-13);
        make.width.offset =AdaptedWidth(100);
        make.height.offset =AdaptedHeight(15);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset =AdaptedHeight(20);
        make.right.offset =AdaptedWidth(-11);
        make.width.height.offset =AdaptedHeight(20);
    }];
}





#pragma mark ------ lazy UI
- (void)configerUI {
    [self.contentView addSubview:self.goodsTitle];
    [self.contentView addSubview:self.goodsPrice];
    [self.contentView addSubview:self.shareBtn];
    [self.contentView addSubview:self.oldPrice];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.decLab];
    
}

- (UILabel *)goodsTitle {
    if (!_goodsTitle){
        _goodsTitle = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_14];
        _goodsTitle.numberOfLines = 2;
    }
    return _goodsTitle;
}

- (UIButton *)shareBtn {
    if (!_shareBtn){
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
    }
    return _shareBtn;
}
- (UILabel *)goodsPrice {
    if (!_goodsPrice){
        _goodsPrice = [UILabel createLabelTextColor:RedColor font:AdaptedBOLDSYSFontSize(18)];
    }
    return _goodsPrice;
}

- (UIView *)line {
    if (!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor = RGBSigle(153);
    }
    return _line;
}

- (UILabel *)oldPrice {
    if (!_oldPrice){
        _oldPrice = [UILabel createLabelTextColor:RGBSigle(153) font:kFont_12];
    }
    return _oldPrice;
}

- (UILabel *)decLab {
    if (!_decLab){
        _decLab = [UILabel createLabelTextColor:RGBSigle(153) font:kFont_12];
        _decLab.textAlignment =NSTextAlignmentRight;
    }
    return _decLab;
}




@end
