//
//  KLBargainTitleTableViewCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/22.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLBargainTitleTableViewCell.h"


@interface KLBargainTitleTableViewCell ()

@property (nonatomic, strong) UIButton * titleBtn;

@end

@implementation KLBargainTitleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleBtn];
        [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.offset =0;
            make.height.offset =AdaptedHeight(18);
            make.width.offset =AdaptedWidth(100);
        }];
    }
    return self;
}

- (UIButton *)titleBtn {
    if (!_titleBtn){
        _titleBtn = [UIButton createBtnTitle:@"为你推荐" titleColor:RGBSigle(51) font:kFont_14 imageName:@"shoushou" backgrounColor:[UIColor clearColor] SSImagePositionType:SSImagePositionTypeLeft spacing:5 action:^(UIButton * _Nonnull button) {
            
        }];
    }
    return _titleBtn;
}


@end
