//
//  KLTodaySpecialCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLTodaySpecialCell.h"

@implementation KLTodaySpecialCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configerUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = MainWidth-AdaptedWidth(178);
    self.goodsName.text = [NSString getBlankString:self.goodsName.text];
    CGSize size = [self.goodsName getLableRectWithMaxWidth:width];
    [self.goodsName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset   = AdaptedWidth(163);
        make.width.offset  = width;
        make.height.offset = size.height +AdaptedHeight(5);
        make.top.offset    = AdaptedHeight(23);
    }];
    
    
    NSString *goodsPrice = [NSString getBlankString:self.goodsPrice.text];
    CGFloat priceW = [UILabel getWidthWithTitle:goodsPrice font:self.goodsPrice.font];
    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset = AdaptedHeight(-58);
        make.width.offset  = priceW;
        make.height.offset = AdaptedHeight(15);
        make.left.mas_equalTo(self.goodsName);
    }];
    
    
    NSString *goodsOldPrice = [NSString getBlankString:self.goodsOldPrice.text];
    CGFloat oldPriceW = [UILabel getWidthWithTitle:goodsOldPrice font:self.goodsOldPrice.font];
    [self.goodsOldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsPrice.mas_bottom).offset = AdaptedHeight(17);
        make.height.offset = AdaptedHeight(15);
        make.width.offset  = oldPriceW;
        make.left.mas_equalTo(self.goodsPrice);
    }];
    
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.goodsOldPrice);
        make.height.offset = 1;
        make.width.offset  = oldPriceW + AdaptedWidth(8);
    }];
    
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset        = AdaptedWidth(-24);
        make.width.height.offset = AdaptedWidth(20);
        make.bottom.offset       = AdaptedHeight(-52);
    }];
    
    
    NSString *goodsSoldNum = [NSString getBlankString:self.goodsSoldNum.text];
    CGFloat soldNumW = [UILabel getWidthWithTitle:goodsSoldNum font:self.goodsSoldNum.font];
    [self.goodsSoldNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.goodsOldPrice);
        make.right.offset  = AdaptedWidth(-24);
        make.height.offset = AdaptedHeight(15);
        make.width.offset  = soldNumW;
    }];
    
}

- (void)configerUI {
    
    [self.contentView addSubview:self.goodsImg];
    [self.contentView addSubview:self.goodsName];
    [self.contentView addSubview:self.goodsPrice];
    [self.contentView addSubview:self.goodsOldPrice];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.addBtn];
    [self.contentView addSubview:self.goodsSoldNum];
    
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =AdaptedWidth(10);
        make.height.width.offset =AdaptedWidth(123);
        make.centerY.offset = 0;
    }];

}

- (UIImageView *)goodsImg {
    if (!_goodsImg){
        _goodsImg = [[UIImageView alloc]init];
        _goodsImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodsImg;
}

- (UILabel *)goodsName {
    if (!_goodsName){
        _goodsName = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_14];
        _goodsName.numberOfLines =2;
    }
    return _goodsName;
}

- (UILabel *)goodsPrice {
    if (!_goodsPrice){
        _goodsPrice = [UILabel createLabelTextColor:RedColor font:kFont_14];
    }
    return _goodsPrice;
}

- (UILabel *)goodsOldPrice {
    if (!_goodsOldPrice){
        _goodsOldPrice = [UILabel createLabelTextColor:RGBSigle(153) font:kFont_12];
    }
    return _goodsOldPrice;
}

- (UIView *)line {
    if (!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor = RGBSigle(153);
    }
    return _line;
}

- (UILabel *)goodsSoldNum {
    if (!_goodsSoldNum){
        _goodsSoldNum = [UILabel createLabelTextColor:RGBSigle(153) font:kFont_12];
        _goodsSoldNum.textAlignment = NSTextAlignmentRight;
    }
    return _goodsSoldNum;
}


- (UIButton *)addBtn {
    if (!_addBtn){
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn addTarget:self action:@selector(addShoppingCarChick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}


//***  加入购物车  **/
- (void)addShoppingCarChick:(UIButton *)sender {
    
    
}


@end
