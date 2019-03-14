//
//  KLGoodsDetailAddressOrSpecCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLGoodsDetailAddressOrSpecCell.h"

@implementation KLGoodsDetailAddressOrSpecCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configerUI];
    }
    return self;
}

- (void)setSpecText:(NSString *)specText {
    _specText = specText;
    self.textLab.text = specText;
}

- (void)configerUI {
    [self titleLab];
    [self textLab];
    [self angleImg];
    [self speaLine];
}

- (UIView *)speaLine {
    if (!_speaLine){
        _speaLine = [UIView zj_viewWithBackColor:SpacColor
                                         supView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.right.top.offset = 0;
                                         make.height.offset = AdaptedHeight(5);
                                     }];
    }
    return _speaLine;
}


- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.centerY.offset = AdaptedHeight(5);
                                          make.left.offset    = AdaptedWidth(10);
                                          make.height.offset  = AdaptedHeight(15);
                                          make.width.offset   = AdaptedWidth(45);
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
                                         make.centerY.offset = AdaptedHeight(5);
                                         make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(5);
                                         make.height.offset = AdaptedHeight(15);
                                         make.width.offset  = MainWidth - AdaptedWidth(90);
                                     }];
    }
    return _textLab;
}

- (UIImageView *)angleImg {
    if (!_angleImg){
        _angleImg = [UIImageView zj_imageViewWithImage:@"more"
                                             SuperView:self.contentView
                                           constraints:^(MASConstraintMaker *make) {
                                               make.right.offset = -15;
                                               make.centerY.offset = AdaptedHeight(5);
                                               make.height.offset =AdaptedHeight(15);
                                               make.width.offset =AdaptedWidth(12);
                                           }];
        _angleImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _angleImg;
}



@end
