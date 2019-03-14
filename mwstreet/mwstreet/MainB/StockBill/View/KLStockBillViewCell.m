//
//  KLStockBillViewCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/26.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStockBillViewCell.h"

@implementation KLStockBillViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}


- (void)configUI {
    [self selectBtn];
    [self goodsImg];
    [self goodsTitleLab];
    [self specLab];
    [self stockLab];
    [self numberButton];
    [self priceLab];
}

- (void)setGoodsTitle:(NSString *)goodsTitle {
    _goodsTitle  = goodsTitle;
    self.goodsTitleLab.text = goodsTitle;
    CGSize size = [self.goodsTitleLab getLableRectWithMaxWidth:MainWidth-AdaptedWidth(171)];
    [self.goodsTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.goodsImg.mas_right).offset = AdaptedWidth(34);
        make.right.offset = AdaptedWidth(-15);
        make.top.mas_equalTo(self.goodsImg.mas_top).offset = AdaptedHeight(5);
        make.height.offset = size.height > AdaptedHeight(35) ? size.height + AdaptedHeight(5) : AdaptedHeight(35);
    }];

}


//***  勾选商品  **/
- (void)selectBtnChick:(UIButton *)sender {

    self.select = !self.select;
    UIImage *selectBtnImage = (self.select)? [UIImage imageNamed:@"dui"] : [UIImage imageNamed:@"yuan"];
    [sender setImage:selectBtnImage forState:UIControlStateNormal];
    self.selectBlock ? self.selectBlock(sender) : nil;
}



- (UIButton *)selectBtn {
    if (!_selectBtn){
        @weakify(self)
        _selectBtn = [UIButton zj_buttonWithTitle:nil
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset         = AdaptedWidth(10);
                                          make.width.height.offset = AdaptedWidth(25);
                                          make.centerY.offset      = AdaptedHeight(-18);
                                      } touchUp:^(id sender) {
                                          @strongify(self)
                                          [self selectBtnChick:sender];
                                      }];
        [_selectBtn setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
    }
    return _selectBtn;
}

- (UIImageView *)goodsImg {
    if (!_goodsImg){
        _goodsImg = [UIImageView zj_imageViewWithImage:@"pic_1"
                                             SuperView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.offset   = AdaptedWidth(40);
                                               make.height.offset = AdaptedHeight(82);
                                               make.width.offset  = AdaptedWidth(83);
                                               make.top.offset    = AdaptedHeight(19);
                                            }];
        _goodsImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodsImg;
}


- (UILabel *)goodsTitleLab {
    if (!_goodsTitleLab){
        _goodsTitleLab = [UILabel zj_labelWithFontSize:12
                                                 lines:2
                                                  text:nil
                                             textColor:RGBSigle(51)
                                             superView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.left.mas_equalTo(self.goodsImg.mas_right).offset = AdaptedWidth(34);
                                               make.right.offset = AdaptedWidth(-15);
                                               make.top.mas_equalTo(self.goodsImg.mas_top).offset = AdaptedHeight(5);
                                               make.height.offset = AdaptedHeight(15);
                                           }];
        _goodsTitleLab.lineSpace = 4;
    }
    return _goodsTitleLab;
}

- (UILabel *)specLab {
    if (!_specLab){
        _specLab = [UILabel zj_labelWithFontSize:12
                                        textColor:TitleColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.mas_equalTo(self.goodsTitleLab);
                                          make.right.offset  = AdaptedWidth(-15);                                          make.top.mas_equalTo(self.goodsTitleLab.mas_bottom).offset= AdaptedHeight(10);
                                          make.height.offset = AdaptedHeight(15);
                                      }];
    }
    return _specLab;
}

- (UILabel *)stockLab {
    if (!_stockLab){
        _stockLab = [UILabel zj_labelWithFontSize:12
                                            lines:1
                                             text:nil
                                        textColor:RGBSigle(255)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset = AdaptedWidth(8);
                                          make.width.offset= AdaptedWidth(133);
                                          make.bottom.offset =AdaptedHeight(-15);
                                          make.top.mas_equalTo(self.goodsImg.mas_bottom).offset =AdaptedHeight(5);
                                      }];
        _stockLab.backgroundColor = LineColor;
        _stockLab.textAlignment = NSTextAlignmentCenter;
    }
    return _stockLab;
}

- (KLNumberButton *)numberButton
{
    if (!_numberButton) {
        _numberButton = [[KLNumberButton alloc]init];
        @weakify(self)
        _numberButton.numberBlock = ^(UILabel * _Nonnull numLab) {
            @strongify(self)
            self.numberBlock ? self.numberBlock(numLab, self.indexPath) : nil;
        };
        [self.contentView addSubview:_numberButton];
        [_numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.stockLab.mas_right).offset =AdaptedWidth(15);
            make.height.offset =AdaptedHeight(22);
            make.width.offset =AdaptedWidth(90);
            make.bottom.offset =AdaptedHeight(-15);
        }];
    }
    return _numberButton;
}


- (UILabel *)priceLab {
    if (!_priceLab){
        _priceLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:nil
                                        textColor:RedColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.right.offset =AdaptedWidth(-15);
                                          make.left.mas_equalTo(self.numberButton.mas_right).offset =AdaptedWidth(20);
                                          make.height.offset =AdaptedHeight(15);
                                          make.centerY.mas_equalTo(self.numberButton);
                                      }];
        _priceLab.textAlignment =NSTextAlignmentRight;
    }
    return _priceLab;
}

@end
