//
//  KLStorePetChangeCollectViewCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLStorePetChangeCollectViewCell.h"

@implementation KLStorePetChangeCollectViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.nameLab];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset =AdaptedWidth(10);
            make.bottom.offset =AdaptedHeight(-14);
            make.right.offset =AdaptedWidth(-10);
            make.height.offset = AdaptedHeight(15);
        }];
    }
    return self;
}
- (UIImageView *)imgView {
    if (!_imgView){
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}

- (UILabel *)nameLab {
    if (!_nameLab){
        _nameLab = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_14];
    }
    return _nameLab;
}


@end
