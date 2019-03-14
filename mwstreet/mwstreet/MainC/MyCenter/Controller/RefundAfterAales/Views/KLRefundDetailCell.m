//
//  KLRefundDetailCell.m
//  mwstreet
//
//  Created by 科pro on 2019/3/4.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLRefundDetailCell.h"

@implementation KLRefundDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self titleLab];
    [self contentLab];
    [self timeLab];
}


- (void)setContent:(NSString *)content {
    _content = content;
    self.contentLab.text = content;
    CGSize size =[self.contentLab getLableRectWithMaxWidth:MainWidth - AdaptedWidth(46)];
    self.contentLab.mj_h = size.height;
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset = AdaptedHeight(18);
        make.bottom.offset = AdaptedHeight(-37);
    }];
}


- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                            lines:0
                                             text:nil
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset   = AdaptedWidth(34);
                                          make.right.offset  = AdaptedWidth(-12);
                                          make.top.offset    = AdaptedHeight(20);
                                          make.height.offset = AdaptedHeight(15);
                                      }];
    }
    return _titleLab;
}

- (UILabel *)contentLab {
    if (!_contentLab){
        _contentLab = [UILabel zj_labelWithFontSize:12
                                              lines:0
                                               text:nil
                                          textColor:TitleColor
                                          superView:self.contentView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.left.right.mas_equalTo(self.titleLab);
                                            make.top.mas_equalTo(self.titleLab.mas_bottom).offset = AdaptedHeight(18);
                                            make.bottom.offset = AdaptedHeight(-37);
                                        }];
        _contentLab.lineSpace = 5;
    }
    return _contentLab;
}

- (UILabel *)timeLab {
    if (!_timeLab){
        _timeLab = [UILabel zj_labelWithFontSize:12
                                           lines:0
                                            text:nil
                                       textColor:TextColor
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.right.mas_equalTo(self.titleLab);
                                         make.height.offset = AdaptedHeight(15);
                                         make.bottom.offset = AdaptedHeight(-14);
                                     }];
    }
    return _timeLab;
}


@end
