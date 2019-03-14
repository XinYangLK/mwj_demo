//
//  KLOrderAddressCell.m
//  mwstreet
//
//  Created by 科pro on 2019/2/25.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLOrderAddressCell.h"

@implementation KLOrderAddressCell

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
    [self statusLab];
    [self addressLab];
    [self angleImg];    
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
                                         make.right.offset  = AdaptedWidth(-14);
                                     }];
    }
    return _nameLab;
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
            make.centerY.offset = 0;
            make.height.offset =AdaptedHeight(15);
            make.width.offset =AdaptedWidth(12);
        }];
    }
    return _angleImg;
}


@end
