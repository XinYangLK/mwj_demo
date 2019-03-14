//
//  KLBGoodsAttributeCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/27.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBGoodsAttributeCell.h"

@implementation KLBGoodsAttributeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}
- (void)configUI {
    [self titleLab];
    [self textLab];
}

- (void)setTextMsg:(NSString *)textMsg {
    _textMsg = textMsg;
    self.textLab.text = textMsg;
    CGSize size =[self.textLab getLableRectWithMaxWidth:MainWidth - (MainWidth/2-AdaptedWidth(52))-AdaptedWidth(25)];
    self.textLab.height = size.height;
    [self.textLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(10);
        make.right.offset = AdaptedWidth(-15);
        make.bottom.offset =AdaptedHeight(-10);
        make.top.offset = AdaptedHeight(10);
    }];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:0
                                             text:nil
                                        textColor:TextColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset   = AdaptedWidth(12);
                                          make.width.offset  = MainWidth/2-AdaptedWidth(52);
                                          make.height.offset = AdaptedHeight(20);
                                          make.centerY.offset= 0;
                                      }];
    }
    return _titleLab;
}

- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel zj_labelWithFontSize:14
                                           lines:0
                                            text:nil
                                       textColor:RGBSigle(51)
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {                                         make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(10);
                                         make.right.offset = AdaptedWidth(-15);
                                         make.centerY.mas_equalTo(self.titleLab);
                                         make.height.offset = AdaptedHeight(20);
                                     }];
        _textLab.lineSpace = 8;
    }
    return _textLab;
}



@end
