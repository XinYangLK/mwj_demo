//
//  KLIntegralGoodsListCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLIntegralGoodsListCell.h"

@implementation KLIntegralGoodsListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self line];
    [self ImgV];
    [self titleLab];
    [self textLab];
    [self numLab];
    [self exchangeBtn];
}
- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.right.top.offset = 0;
                                     make.height.offset = 0.5f;
                                 }];
        _line.hidden = YES;
    }
    return _line;
}

- (UIImageView *)ImgV {
    if (!_ImgV){
        _ImgV = [UIImageView zj_imageViewWithImage:nil
                                         SuperView:self.contentView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.left.offset   = AdaptedWidth(10);
                                           make.top.offset    = AdaptedHeight(14);
                                           make.bottom.offset = AdaptedHeight(-16);
                                           make.width.offset  = AdaptedWidth(120);
                                       }];
    }
    return _ImgV;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.mas_equalTo(self.ImgV.mas_right).offset = 18;
                                          make.right.offset =AdaptedWidth(-12);
                                          make.height.offset =AdaptedHeight(15);
                                          make.top.mas_equalTo(self.ImgV);
                                      }];
    }
    return _titleLab;
}

- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel zj_labelWithFontSize:12
                                       textColor:TextColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.height.left.mas_equalTo(self.titleLab);
                                         make.width.offset  = AdaptedWidth(120);
                                         make.bottom.offset = AdaptedHeight(-45); ;
                                     }];
    }
    return _textLab;
}

- (UILabel *)numLab {
    if (!_numLab){
        _numLab = [UILabel zj_labelWithFontSize:14
                                      textColor:MainColor
                                      superView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.width.left.height.mas_equalTo(self.textLab);
                                        make.bottom.mas_equalTo(self.ImgV);
                                    }];
    }
    return _numLab;
}

- (UIButton *)exchangeBtn {
    if (!_exchangeBtn){
        @weakify(self)
        _exchangeBtn = [UIButton zj_buttonWithTitle:@"去兑换"
                                         titleColor:RGBSigle(255)
                                          backColor:MainColor
                                           fontSize:14
                                             isBold:NO
                                       cornerRadius:5
                                            supView:self.contentView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.right.offset  = AdaptedWidth(-10);
                                            make.bottom.offset = AdaptedHeight(-22);
                                            make.height.offset = AdaptedHeight(28);
                                            make.width.offset  = AdaptedWidth(70);
                                        } touchUp:^(id sender) {
                                           @strongify(self)
                                            self.exchangeBlock ? self.exchangeBlock(self.indexPath) : nil;
                                        }];
    }
    return _exchangeBtn;
}


@end
