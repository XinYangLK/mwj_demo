//
//  KLStoreServiceDetailCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/31.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStoreServiceDetailCell.h"

@interface KLStoreServiceDetailCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *textLab;


@end

@implementation KLStoreServiceDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configerUI];
    }
    return self;
}


- (void)configerUI {
    [self titleLab];
    [self textLab];
}

- (void)setTitle:(NSString *)title {
    _title =title;
    _titleLab.text = title;
}

-(void)setText:(NSString *)text {
    _text =text;
    self.textLab.text =_text;
    CGSize size =[self.textLab getLableRectWithMaxWidth:MainWidth-100];
    [self.textLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_top);
        make.bottom.offset = 0;
        make.left.mas_equalTo(self.titleLab.mas_right);
        make.width.offset = size.width;
    }];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:12
                                            lines:1
                                             text:nil
                                        textColor:TitleColor
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset = AdaptedHeight(10);
                                          make.height.offset =AdaptedHeight(18);
                                          make.top.offset =AdaptedHeight(15);
                                          make.width.offset =AdaptedWidth(70);
                                      }];
    }
    return _titleLab;
}

- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_13];
        _textLab.lineSpace = 8;
        _textLab.numberOfLines =0;
        _textLab.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:_textLab];
        [_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = AdaptedWidth(-10);
            make.top.mas_equalTo(self.titleLab.mas_top);
            make.bottom.offset = 0;
            make.left.mas_equalTo(self.titleLab.mas_right);
        }];
    }
    return _textLab;
}

@end
