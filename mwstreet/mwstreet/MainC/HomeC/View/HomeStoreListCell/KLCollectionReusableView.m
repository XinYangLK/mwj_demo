//
//  KLCollectionReusableView.m
//  mwstreet
//
//  Created by 科pro on 2019/1/9.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLCollectionReusableView.h"

@implementation KLCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headerImg];
        [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

- (UIImageView *)headerImg {
    if (!_headerImg){
        _headerImg = [[UIImageView alloc]init];
    }
    return _headerImg;
}


@end
