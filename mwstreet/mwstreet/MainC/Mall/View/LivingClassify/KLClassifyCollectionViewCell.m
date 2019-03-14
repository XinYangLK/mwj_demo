//
//  KLClassifyCollectionViewCell.m
//  mwstreet
//
//  Created by 科pro on 2019/1/21.
//  Copyright © 2019 xunben. All rights reserved.
//

#import "KLClassifyCollectionViewCell.h"

@implementation KLClassifyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self configerUI];
    }
    return self;
}

- (void)configerUI {
    [self.contentView addSubview:self.classifyImg];
    [self.contentView addSubview:self.classifyTitle];
    CGFloat spaceW = AdaptedWidth(10);
    CGFloat width = (MainWidth - spaceW * 3 -AdaptedWidth(112)) / 3;
    [self.classifyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset =0;
        make.top.offset =AdaptedHeight(5);
        make.width.offset =width-AdaptedWidth(14);
        make.height.offset =AdaptedHeight(53);
    }];
    [self.classifyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset =0;
        make.height.offset =AdaptedHeight(15);
        make.top.mas_equalTo(self.classifyImg.mas_bottom).offset =AdaptedHeight(18);
        make.width.offset = width -AdaptedWidth(10);
    }];
}


-(UIImageView *)classifyImg {
    if (!_classifyImg){
        _classifyImg = [[UIImageView alloc]init];
        _classifyImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _classifyImg;
}

- (UILabel *)classifyTitle {
    if (!_classifyTitle){
        _classifyTitle = [UILabel createLabelTextColor:RGBSigle(51) font:kFont_14];
        _classifyTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _classifyTitle;
}

@end
