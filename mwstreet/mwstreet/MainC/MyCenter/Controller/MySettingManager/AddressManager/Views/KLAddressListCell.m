//
//  KLAddressListCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/20.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLAddressListCell.h"

@implementation KLAddressListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self confinerUI];
    }
    return self;
}
- (void)confinerUI {
    
    [self nameLab];
    [self phoneLab];
    [self statusLab];
    [self addressLab];
    [self angleImg];
    [self line];
    [self delectBtn];
    [self editBtn];

}

- (UILabel *)nameLab {
    if (!_nameLab){
        _nameLab = [UILabel zj_labelWithFontSize:14
                                       textColor:RGBSigle(51)
                                       superView:self.contentView
                                     constraints:^(MASConstraintMaker *make) {
                                         make.left.offset   = AdaptedWidth(14);
                                         make.top.offset    = AdaptedHeight(16);
                                         make.height.offset = AdaptedHeight(15);
                                         make.width.offset  = AdaptedWidth(130);
        }];
    }
    return _nameLab;
}

- (UILabel *)phoneLab {
    if (!_phoneLab){
        _phoneLab = [UILabel zj_labelWithFontSize:14
                                        textColor:RGBSigle(51)
                                        superView:self.contentView
                                      constraints:^(MASConstraintMaker *make) {
                                          make.left.mas_equalTo(self.nameLab.mas_right).offset   = AdaptedWidth(10);
                                          make.right.offset  = AdaptedWidth(-12);
                                          make.top.height.mas_equalTo(self.nameLab);
                                      }];
    }
    return _phoneLab;
}

- (UILabel *)statusLab {
    if (!_statusLab){
        _statusLab = [UILabel zj_labelWithFontSize:12
                                         textColor:RGBSigle(255)
                                         superView:self.contentView
                                       constraints:^(MASConstraintMaker *make) {
                                           make.left.mas_equalTo(self.nameLab);
                                           make.width.offset  = AdaptedWidth(37);
                                           make.height.offset =AdaptedHeight(18);
                                           make.top.mas_equalTo(self.nameLab.mas_bottom).offset =AdaptedHeight(18);
                                       }];
        _statusLab.numberOfLines = 0;
        _statusLab.backgroundColor = RedColor;
        _statusLab.textAlignment = NSTextAlignmentCenter;
        [_statusLab setLayerCornerRadius:AdaptedHeight(9)];
    }
    return _statusLab;
}

- (UILabel *)addressLab {
    if (!_addressLab){
        _addressLab = [UILabel zj_labelWithFontSize:14
                                          textColor:RGBSigle(51)
                                          superView:self.contentView
                                        constraints:^(MASConstraintMaker *make) {
                                            make.left.mas_equalTo(self.statusLab.mas_right).offset   = AdaptedWidth(22);
                                            make.right.offset  = AdaptedWidth(-37);
                                            make.top.mas_equalTo(self.statusLab);
                                            make.height.offset = AdaptedHeight(15);
                                        }];
    }
    return _addressLab;
}


- (UIImageView *)angleImg {
    if (!_angleImg){
        _angleImg = [[UIImageView alloc]init];
        _angleImg.contentMode = UIViewContentModeScaleAspectFit;
        _angleImg.image = [UIImage imageNamed:@"more"];
        [self.contentView addSubview:_angleImg];
        [_angleImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = -15;
            make.centerY.mas_equalTo(self.statusLab);
            make.height.offset =AdaptedHeight(15);
            make.width.offset =AdaptedWidth(12);
        }];
    }
    return _angleImg;
}


- (UIView *)line {
    if (!_line){
        _line = [UIView zj_viewWithBackColor:LineColor
                                     supView:self.contentView
                                 constraints:^(MASConstraintMaker *make) {
                                     make.left.right.offset = 0;
                                     make.height.offset = 0.5f;
                                     make.bottom.offset =AdaptedHeight(-40);
                                 }];
    }
    return _line;
}


- (UIButton *)delectBtn {
    if (!_delectBtn){
        _delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delectBtn setImage:[UIImage imageNamed:@"degghgh"] forState:UIControlStateNormal];
        [self.contentView addSubview:_delectBtn];
        [_delectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.offset = AdaptedHeight(30);
            make.right.offset        = AdaptedWidth(-24);
            make.bottom.offset       = AdaptedHeight(-5);
        }];
    }
    return _delectBtn;
    
}
- (UIButton *)editBtn {
    if (!_editBtn){
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
        _editBtn.imageView.contentMode =UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_editBtn];
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.offset = AdaptedHeight(17);
            make.right.mas_equalTo(self.delectBtn.mas_left).offset  = AdaptedWidth(-24);
            make.bottom.offset       = AdaptedHeight(-13);
        }];
    }
    return _editBtn;
}




@end
