//
//  KLServerOrderCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLServerOrderCell.h"

@implementation KLServerOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI {
    [self serImg];
    [self titleLab];
    [self priceLab];
    [self decLab];
}

- (UIImageView *)serImg {
    if (!_serImg){
        _serImg = [UIImageView zj_imageViewWithImage:@"gipjd_1"
                                           SuperView:self.contentView
                                         constraints:^(MASConstraintMaker *make) {
                                             make.left.offset = AdaptedWidth(11);
                                             make.width.height.offset =AdaptedHeight(48);
                                             make.centerY.offset =0;
                                         }];
    }
    return _serImg;
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:1
                                             text:@"[ 洗澡 ]小型犬"
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.mas_equalTo(self.serImg.mas_right).offset =AdaptedWidth(28);
                                          make.height.offset =AdaptedHeight(15);
                                          make.top.mas_equalTo(self.serImg);
                                          make.right.mas_equalTo(-75);
                                      }];
    }
    return  _titleLab;
}

- (UILabel *)priceLab {
    if (!_priceLab){
        _priceLab = [UILabel zj_labelWithFontSize:12
                                            lines:1
                                             text:@"1件/总价：￥30.00"
                                        textColor:TextColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.height.right.left.mas_equalTo(self.titleLab);
                                          make.bottom.mas_equalTo(self.serImg);
                                      }];
    }
    return _priceLab;
}

- (UILabel *)decLab {
    if (!_decLab){
        _decLab = [UILabel zj_labelWithFontSize:14
                                          lines:1
                                           text:@"￥30.00"
                                      textColor:RedColor
                                      superView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.top.height.mas_equalTo(self.titleLab);
                                        make.right.offset =AdaptedWidth(-12);
                                        make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(5);
                                    }];
        _decLab.textAlignment = NSTextAlignmentCenter;
    }
    return _decLab;
}
@end
