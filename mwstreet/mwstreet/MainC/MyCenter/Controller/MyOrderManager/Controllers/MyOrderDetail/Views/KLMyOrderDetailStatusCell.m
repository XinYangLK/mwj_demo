//
//  KLMyOrderDetailStatusCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLMyOrderDetailStatusCell.h"

@implementation KLMyOrderDetailStatusCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = MainColor;
        [self configUI];
    }
    return self;
}
- (void)configUI {
    [self titleLab];
    [self textLab];
}

- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:[UIColor whiteColor]
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(13);
                                          make.centerY.offset = 0;
                                          make.width.offset =AdaptedWidth(130);
                                          make.height.offset =AdaptedHeight(15);
                                      }];
        _titleLab.backgroundColor = [UIColor clearColor];
    }
    return _titleLab;
}

- (UILabel *)textLab {
    if (!_textLab){
        _textLab = [UILabel zj_labelWithFontSize:12
                                       textColor:[UIColor whiteColor]
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(10);
                                         make.right.offset =AdaptedWidth(-12);
                                         make.height.centerY.mas_equalTo(self.titleLab);
                                       }];
        _textLab.backgroundColor = [UIColor clearColor];
    }
    return _textLab;
}

@end




@implementation KLMyOrderDetailAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}
- (void)configUI {
    [self nameLab];
    [self addressLab];
}

- (UILabel *)nameLab {
    if (!_nameLab){
        _nameLab = [UILabel zj_labelWithFontSize:14
                                       textColor:RGBSigle(51)
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.offset = AdaptedWidth(12);
                                         make.right.offset =AdaptedWidth(-12);
                                         make.height.offset =AdaptedHeight(15);
                                         make.top.offset =AdaptedHeight(15);
                                     }];
    }
    return _nameLab;
}

- (UILabel *)addressLab {
    if (!_addressLab){
        _addressLab = [UILabel zj_labelWithFontSize:12
                                          textColor:RGBSigle(51)
                                          superView:self.contentView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.height.right.left.mas_equalTo(self.nameLab);
                                            make.top.mas_equalTo(self.nameLab.mas_bottom).offset =AdaptedHeight(14);
                                        }];
    }
    return _addressLab;
}

@end



@implementation KLMyOrderDetailMsgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configeUI];
    }
    return self;
}


- (void)configeUI {
    [self titleLab];
    [self msgLab];
}


- (UILabel *)titleLab {
    if (!_titleLab){
        _titleLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.offset =AdaptedWidth(12);
                                          make.height.offset = AdaptedHeight(15);
                                          make.centerY.offset = 0;
                                          make.width.offset =AdaptedWidth(85);
                                      }];
    }
    return _titleLab;
}
- (UILabel *)msgLab {
    if (!_msgLab){
        _msgLab = [UILabel zj_labelWithFontSize:14 textColor:RGBSigle(51) superView:self.contentView
                                    constraints:^(MASConstraintMaker *make) {
                                        make.left.mas_equalTo(self.titleLab.mas_right).offset =AdaptedWidth(5);
                                        make.right.offset = AdaptedWidth(-12);
                                        make.height.centerY.mas_equalTo(self.titleLab);
                                    }];
    }
    return _msgLab;
}

@end
