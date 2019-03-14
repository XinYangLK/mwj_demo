//
//  KLNavigationSearchBtn.m
//  mwstreet
//
//  Created by 科pro on 2018/12/28.
//  Copyright © 2018 xunben. All rights reserved.
//

#import "KLNavigationSearchBtn.h"

@implementation KLNavigationSearchBtn

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:RGBSigle(242)];
        [self setLayerCornerRadius:5];

        [self addSubview:self.searchImg];
        [self addSubview:self.searchLab];
        
        [self.searchImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset =AdaptedWidth(10);
            make.centerY.offset =0;
            make.width.height.offset =AdaptedHeight(13);
        }];
        [self.searchLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.searchImg.mas_right).offset =AdaptedWidth(10);
            make.centerY.mas_equalTo(self.searchImg);
            make.right.offset =AdaptedWidth(-15);
            make.height.offset =AdaptedHeight(15);
        }];
    }
    return self;
}

- (UILabel *)searchLab {
    if (!_searchLab){
        _searchLab = [UILabel createLabelTextColor:TextColor font:kFont_14];;
    }
    return _searchLab;
}
- (UIImageView *)searchImg {
    if (!_searchImg){
        _searchImg = [[UIImageView alloc]init];
        _searchImg.image =[UIImage imageNamed:@"search"];
    }
    return _searchImg;
}


@end
